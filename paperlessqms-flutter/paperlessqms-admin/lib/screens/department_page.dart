/*
 * Copyright (c) since 2024 Wheref.com <https://github.com/codeeuser>
 * 
 * NOTICE OF LICENSE
 * 
 * This source file is subject to the Open Software License (OSL 3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/OSL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to hello@wheref.com so we can send you a copy immediately.
 * 
 * DISCLAIMER
 * 
 * Do not edit or add to this file if you wish to upgrade PaperlessQMS to newer
 * versions in the future. If you wish to customize PaperlessQMS for your
 * needs please refer to https://wheref.com/ for more information.
 * 
 * @author wheref
 * @copyright since 2024 Wheref.com
 * @license   https://opensource.org/licenses/OSL-3.0 Open Software License (OSL 3.0)
 * 
 */

// ignore_for_file: use_build_context_synchronously

import 'package:admin/logger.dart';
import 'package:admin/widgets/queue_service_widget.dart';
import 'package:common/app_absorb.dart';
import 'package:common/bloc/department_bloc.dart';
import 'package:common/bloc/service_bloc.dart';
import 'package:common/generated/l10n.dart';
import 'package:common/models/queue_department_model.dart';
import 'package:common/models/queue_service_model.dart';
import 'package:common/utils/constants.dart';
import 'package:common/utils/functions.dart';
import 'package:common/utils/no_data.dart';
import 'package:common/utils/validation_function.dart';
import 'package:common/widgets/error_box_widget.dart';
import 'package:common/widgets/msg_box_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DepartmentPage extends StatefulWidget {
  final SharedPreferences prefs;
  final QueueDepartmentModel? department;
  const DepartmentPage({super.key, required this.prefs, this.department});

  @override
  State<DepartmentPage> createState() => _DepartmentPageState();
}

class _DepartmentPageState extends State<DepartmentPage> {
  static const String tag = 'DepartmentPage';
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _bannerController = TextEditingController();
  final ValueNotifier<ActionPage> _action = ValueNotifier(ActionPage.list);
  final ValueNotifier<QueueDepartmentModel> _departmentSelected =
      ValueNotifier(QueueDepartmentModel());
  final ValueNotifier<List<String>> _errors = ValueNotifier([]);
  final ValueNotifier<List<String>> _messages = ValueNotifier([]);
  final ScrollController _createController = ScrollController();

  List<QueueServiceWidget>? _serviceList;
  List<QueueDepartmentModel>? _departmentList;
  @override
  void initState() {
    super.initState();
    _initialize(widget.department);
  }

  Future<void> _initialize(QueueDepartmentModel? department) async {
    _errors.value = [];
    _messages.value = [];
    int? id = department?.id;
    if (department != null && id != null) {
      context.read<DepartmentBloc>().add(DepartmentLoadOneEvent(id: id));
      context
          .read<ServiceBloc>()
          .add(ServiceLoadByDepartmentEvent(department: department));
    } else {
      context.read<DepartmentBloc>().add(DepartmentLoadAllEvent());
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _bannerController.dispose();
    _action.dispose();
    _departmentSelected.dispose();
    _errors.dispose();
    _messages.dispose();
    _createController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _action,
        builder: (context, ActionPage action, _) {
          Widget? w;
          Logger.log(tag, message: 'action: $action');
          if (action == ActionPage.list) {
            w = _buildDepartmentList();
          } else if (action == ActionPage.newItem) {
            w = _buildNewDepartmentForm();
          } else {
            w = const SizedBox();
          }
          return w;
        });
  }

  Widget _buildDepartmentList() {
    TextStyle? style = Theme.of(context).textTheme.headlineSmall;
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    if (width > ScreenProp.widthPhoneScreenLimit) {
      width = ScreenProp.widthPhoneScreenLimit;
    }
    return BlocBuilder<DepartmentBloc, DepartmentState>(
        builder: (context, state) {
      Logger.log(tag, message: 'state: $state');
      if (state is DepartmentLoadingState) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is DepartmentLoadedState) {
        _departmentList = state.departments;
      } else if (state is DepartmentErrorTerminalState) {
        _errors.value = [S.of(context).deleteTerminalFirst];
      } else if (state is DepartmentSuccessState) {
        _messages.value = [S.of(context).success];
      } else if (state is DepartmentErrorState) {
        _errors.value = [state.error.data?.title??''];
      } else if (state is DepartmentMissingBizState){
        return NoData(message: S.of(context).missingBusinessProfile);
      }
      return SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ErrorBoxWidget(errors: _errors, width: width),
            MsgBoxWidget(messages: _messages, width: width),
            _buildCreateBar(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(S.of(context).departmentList, style: style),
                  IconButton.filled(
                    icon: const Icon(CupertinoIcons.add_circled_solid),
                    onPressed: () {
                      _nameController.clear();
                      _descController.clear();
                      _bannerController.clear();
                      _action.value = ActionPage.newItem;
                    },
                  ),
                ],
              ),
            ),
            if (_departmentList == null ||
                _departmentList?.isEmpty == true) ...[
              const Expanded(child: NoData()),
            ] else ...[
              Expanded(
                flex: 10,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (QueueDepartmentModel dep
                          in _departmentList ?? []) ...[
                        _buildDepartmentItem(dep),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      );
    });
  }

  Widget _buildDepartmentItem(QueueDepartmentModel dep) {
    TextStyle? style = Theme.of(context).textTheme.headlineSmall;
    final services = dep.queueServices??[];
    services.sortAscByNullable<num>((e) => e.orderNum);
    return ValueListenableBuilder(
        valueListenable: _departmentSelected,
        builder: (context, QueueDepartmentModel selected, _) {
          if (selected.id == dep.id) {
            dep = selected;
          }
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              shape: const ContinuousRectangleBorder(
                  side: BorderSide(color: Colors.grey)),
              leading: CupertinoSwitch(
                  value: dep.enable ?? false,
                  onChanged: (value) async {
                    context.read<DepartmentBloc>().add(
                        DepartmentEnableEvent(department: dep, enable: value));
                  }),
              title: Text(dep.name ?? '', style: style),
              trailing: IconButton(
                icon: const Icon(CupertinoIcons.trash),
                onPressed: () async {
                  _errors.value = [];
                  _messages.value = [];
                  context
                      .read<DepartmentBloc>()
                      .add(DepartmentRemoveEvent(department: dep));
                },
              ),
              subtitle: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (QueueServiceModel service in services) ...[
                      ChoiceChip(
                        label: Text(service.name ?? ''),
                        selected: false,
                        avatar: const Icon(CupertinoIcons.cursor_rays),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ],
                ),
              ),
              onTap: () async {
                await _initialize(dep);
                _action.value = ActionPage.newItem;
              },
            ),
          );
        });
  }

  Widget _buildNewDepartmentForm() {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    if (width > ScreenProp.widthPhoneScreenLimit) {
      width = ScreenProp.widthPhoneScreenLimit;
    }
    return BlocBuilder<DepartmentBloc, DepartmentState>(
      builder: (context, state) {
        Logger.log(tag, message: 'state: $state');
        QueueDepartmentModel? department;
        if (state is DepartmentOneLoadedState){
          department = state.department;
          _nameController.text = department.name??'';
          _descController.text = department.desc??'';
          _bannerController.text = department.bannerName??'';
        } else if (state is DepartmentSuccessState){
          _messages.value = [S.of(context).success];
        } else if (state is DepartmentErrorState){
          _errors.value = [state.error.data?.title??''];
        } else if (state is DepartmentMissingBizState){
          return NoData(message: S.of(context).missingBusinessProfile);
        }
        return Form(
          key: _formKey,
          child: SizedBox(
            width: width,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonUtils.actionBar(context,
                      title: S.of(context).departmentForm, back: () {
                    _messages.value = [];
                    _errors.value = [];
                    _nameController.clear();
                    _descController.clear();
                    _bannerController.clear();
                    _departmentSelected.value = QueueDepartmentModel();
                    _action.value = ActionPage.list;
                    context.read<DepartmentBloc>().add(DepartmentLoadAllEvent());
                  }, save: () async {
                    _messages.value = [];
                    _errors.value = [];
                    await _saveOrUpdate(department);
                  }),
                  ErrorBoxWidget(errors: _errors, width: width),
                  MsgBoxWidget(messages: _messages, width: width),
                  TextFormField(
                    controller: _nameController,
                    textAlignVertical: TextAlignVertical.center,
                    textCapitalization: TextCapitalization.words,
                    maxLength: 30,
                    decoration: DecoratorUtils.inputDecoration(
                        S.of(context).department,
                        prefixIcon: CupertinoIcons.bookmark,
                        suffixIcon: CupertinoIcons.xmark,
                        clear: () => _nameController.clear()),
                    validator: (value) => ValidateUtils.validateStringMinMax(
                        value, 3, 30, S.of(context).department),
                  ),
                  Constants.divider,
                  TextFormField(
                    controller: _descController,
                    minLines: 5,
                    maxLines: 5,
                    maxLength: 200,
                    textAlignVertical: TextAlignVertical.center,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: DecoratorUtils.inputDecoration(
                        S.of(context).description,
                        prefixIcon: CupertinoIcons.text_bubble,
                        suffixIcon: CupertinoIcons.xmark,
                        clear: () => _descController.clear()),
                  ),
                  Constants.divider,
                  TextFormField(
                    controller: _bannerController,
                    textAlignVertical: TextAlignVertical.center,
                    textCapitalization: TextCapitalization.words,
                    maxLength: 10,
                    decoration: DecoratorUtils.inputDecoration(
                        S.of(context).bannerName,
                        prefixIcon: CupertinoIcons.flag,
                        suffixIcon: CupertinoIcons.xmark,
                        clear: () => _bannerController.clear()),
                    validator: (value) {
                      if (value?.isNotEmpty == true) {
                        return ValidateUtils.validateStringMinMax(
                            value, 3, 10, S.of(context).bannerName);
                      }
                      return null;
                    },
                  ),
                  Constants.divider,
                  const SizedBox(height: 8),
                  if (department==null)...[
                    Text(S.of(context).createServiceAfterSavedDepartment),
                  ] else ...[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        child: FittedBox(
                          child: Row(
                            children: [
                              const Icon(CupertinoIcons.cursor_rays),
                              const SizedBox(width: 4),
                              Text(S.of(context).addService),
                            ],
                          ),
                        ),
                        onPressed: () {
                          QueueServiceModel? service = _createService(department);
                          Logger.log(tag, message: '_createService: $service');
                          if (service!=null) {
                            context.read<ServiceBloc>().add(ServiceAddEvent(service: service));
                          }
                        },
                      ),
                    ),
                  ],
                  BlocBuilder<ServiceBloc, ServiceState>(
                      builder: (context, state) {
                    List<QueueServiceModel>? list;
                    if (state is ServiceLoadedState) {
                      list = state.services;
                    } else if (state is ServiceErrorState) {
                      _errors.value = [state.error.data?.title??''];
                    } 
                    final serviceList = _createServiceWidget(list);
                    if (serviceList == null) return const SizedBox();
                    return ReorderableListView(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        primary: false,
                        shrinkWrap: true,
                        buildDefaultDragHandles: false,
                        children: [
                          for (int i = 0; i < serviceList.length; i++) ...[
                            serviceList.elementAt(i),
                          ],
                        ],
                        onReorder: (int oldIndex, int newIndex) async {
                          Logger.log(tag,
                              message:
                                  'oldIndex: $oldIndex, newIndex: $newIndex');
                          if (oldIndex < newIndex) {
                            newIndex -= 1;
                          }
                          final item = serviceList.removeAt(oldIndex);
                          serviceList.insert(newIndex, item);
                          for (var i = 0; i < serviceList.length; i++) {
                            QueueServiceWidget w = serviceList.elementAt(i);
                            final service = w.queueService;
                            service.orderNum = i;
                            context.read<ServiceBloc>().add(ServiceUpdateEvent(service: service));
                          }
                          _serviceList = serviceList.toList();
                        });
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCreateBar() {
    return SizedBox(
      height: 100,
      child: Row(
        children: [
          RotatedBox(
            quarterTurns: -1,
            child: Text(
              S.of(context).create.toUpperCase(),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Scrollbar(
              controller: _createController,
              child: ListView(
                controller: _createController,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(bottom: 8),
                children: [
                  FutureBuilder<List<Widget>>(
                    future: _createTemplateWorkspaces(),
                    initialData: const [],
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Widget>? widgets = snapshot.data;
                        return Row(
                          children: [
                            for (var w in widgets ?? []) ...[
                              w,
                              const SizedBox(width: 8),
                            ]
                          ],
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Widget>> _createTemplateWorkspaces() async {
    List<Widget> widgets = [];
    Widget w = TextButton(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/1024.png', width: 40, height: 40),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(S.of(context).sample),
            ],
          ),
        ],
      ),
      onPressed: () async {
        AppAbsorb appAbsorb = context.read<AppAbsorb>();
        appAbsorb.absorbing = true;
        _createWorkspace();
        appAbsorb.absorbing = false;
      },
    );
    widgets.add(w);
    return widgets;
  }

  void _createWorkspace() {
    context.read<DepartmentBloc>().add(DepartmentDummyEvent());
  }

  Future<void> _deleteCallback(QueueServiceModel service) async {
    context.read<ServiceBloc>().add(ServiceRemoveEvent(service: service));
  }

  QueueServiceModel? _createService(QueueDepartmentModel? department){
    if (department==null) return null;
    DateTime now = DateTime.now();
    String key = uuid.v4();
    return QueueServiceModel(
      key: key, 
      name: 'Empty',
      letter: 'E',
      start: 1,
      queueDepartment: department,
      orderNum: _serviceList?.length,
      enable: true,
      modifiedDate: now.millisecondsSinceEpoch,
      createdDate: now.millisecondsSinceEpoch,
    );
  }

  List<QueueServiceWidget>? _createServiceWidget(
      List<QueueServiceModel>? list) {
    if (list == null || list.isEmpty) return null;
    list.sortAscByNullable<num>((e) => e.orderNum);
    List<QueueServiceWidget> listWidget = [];
    for (QueueServiceModel e in list) {
      String key = uuid.v4();
      e.key = key;
      final serviceWidget = QueueServiceWidget(
        key: ValueKey(key),
        queueService: e,
        deleteCallback: (queueService) async {
          await _deleteCallback(queueService);
        },
      );
      listWidget.add(serviceWidget);
    }
    _serviceList = listWidget;
    return listWidget.toList();
  }

  Future<void> _saveOrUpdate(QueueDepartmentModel? department) async {
    if (_formKey.currentState!.validate()) {
      List<QueueServiceModel> services = [];
      for (QueueServiceWidget w in _serviceList??[]) {
        services.add(w.queueService);
      }
      context.read<DepartmentBloc>().add(DepartmentSaveOrUpdateEvent(
            id: department?.id,
            name: _nameController.text.trim(),
            desc: _descController.text.trim(),
            banner: _bannerController.text.trim(),
            services: services,
          ));
    }
  }
}
