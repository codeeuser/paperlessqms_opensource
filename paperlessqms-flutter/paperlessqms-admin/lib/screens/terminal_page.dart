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
import 'package:collection/collection.dart';
import 'package:common/bloc/department_bloc.dart';
import 'package:common/bloc/terminal_bloc.dart';
import 'package:common/generated/l10n.dart';
import 'package:common/models/queue_department_model.dart';
import 'package:common/models/queue_terminal_model.dart';
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

class TerminalPage extends StatefulWidget {
  final SharedPreferences prefs;
  final QueueTerminalModel? terminal;
  const TerminalPage(
      {super.key, required this.prefs, this.terminal});

  @override
  State<TerminalPage> createState() => _TerminalPageState();
}

class _TerminalPageState extends State<TerminalPage> {
  static const String tag = 'TerminalPage';
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final ValueNotifier<ActionPage> _action = ValueNotifier(ActionPage.list);
  final ValueNotifier<QueueTerminalModel> _terminalSelected =
      ValueNotifier(QueueTerminalModel(key: uuid.v4()));
  final ValueNotifier<QueueDepartmentModel> _departmentSelected =
      ValueNotifier(QueueDepartmentModel(key: uuid.v4()));
  final ValueNotifier<List<String>> _errors = ValueNotifier([]);
  final ValueNotifier<List<String>> _messages = ValueNotifier([]);

  List<QueueTerminalModel>? _terminalList;

  @override
  void initState() {
    super.initState();
    _initialize(widget.terminal);
  }

  Future<void> _initialize(QueueTerminalModel? terminal) async {
    _errors.value = [];
    _messages.value = [];
    int? id = terminal?.id;
    context.read<DepartmentBloc>().add(DepartmentLoadAllEvent());
    if (terminal != null && id != null) {
      context.read<TerminalBloc>().add(TerminalLoadOneEvent(id: id));
    } else {
      context.read<TerminalBloc>().add(TerminalLoadAllEvent());
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _action.dispose();
    _terminalSelected.dispose();
    _departmentSelected.dispose();
    _errors.dispose();
    _messages.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _action,
        builder: (context, ActionPage action, _) {
          Widget? w;
          if (action == ActionPage.list) {
            w = _buildTerminalList();
          } else if (action == ActionPage.newItem) {
            w = _buildNewTerminalForm();
          } else {
            w = const SizedBox();
          }
          return w;
        });
  }

  Widget _buildTerminalList() {
    TextStyle? style = Theme.of(context).textTheme.headlineSmall;
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    if (width > ScreenProp.widthPhoneScreenLimit) {
      width = ScreenProp.widthPhoneScreenLimit;
    }
    return BlocBuilder<TerminalBloc, TerminalState>(builder: (context, state) {
      Logger.log(tag, message: 'state: $state');
      if (state is TerminalLoadingState) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is TerminalLoadedState) {
        _terminalList = state.terminals;
      } else if (state is TerminalSuccessState) {
        _messages.value = [S.of(context).success];
      } else if (state is TerminalErrorState) {
        _errors.value = [state.error.data?.title??''];
      } else if (state is TerminalMissingBizState) {
        return NoData(message: S.of(context).missingBusinessProfile);
      }
      return SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(S.of(context).terminalList, style: style),
                  IconButton.filled(
                    icon: const Icon(CupertinoIcons.add_circled_solid),
                    onPressed: () {
                      _nameController.clear();
                      _departmentSelected.value =
                          QueueDepartmentModel(key: uuid.v4());
                      _action.value = ActionPage.newItem;
                    },
                  ),
                ],
              ),
            ),
            if (_terminalList?.isEmpty == true) ...[
              const Expanded(child: NoData()),
            ] else ...[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (QueueTerminalModel ter in _terminalList ?? []) ...[
                        _buildTerminalItem(ter),
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

  Widget _buildTerminalItem(QueueTerminalModel ter) {
    TextStyle? style = Theme.of(context).textTheme.headlineSmall;
    return ValueListenableBuilder(
        valueListenable: _terminalSelected,
        builder: (context, QueueTerminalModel selected, _) {
          if (selected.id == ter.id) {
            ter = selected;
          }
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              shape: const ContinuousRectangleBorder(
                  side: BorderSide(color: Colors.grey)),
              leading: CupertinoSwitch(
                  value: ter.enable ?? false,
                  onChanged: (value) async {
                    _terminalSelected.value = ter;
                    context
                        .read<TerminalBloc>()
                        .add(TerminalEnableEvent(terminal: ter, enable: value));
                  }),
              title: Text(ter.name ?? '', style: style),
              trailing: IconButton(
                icon: const Icon(CupertinoIcons.trash),
                onPressed: () async {
                  context
                      .read<TerminalBloc>()
                      .add(TerminalRemoveEvent(terminal: ter));
                },
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ChoiceChip(
                    label: Text(ter.queueDepartment?.name ?? ''),
                    avatar: const Icon(CupertinoIcons.bookmark),
                    selected: false,
                  ),
                ],
              ),
              onTap: () async {
                await _initialize(ter);
                _action.value = ActionPage.newItem;
              },
            ),
          );
        });
  }

  Widget _buildNewTerminalForm() {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    if (width > ScreenProp.widthPhoneScreenLimit) {
      width = ScreenProp.widthPhoneScreenLimit;
    }
    return BlocBuilder<TerminalBloc, TerminalState>(
      builder: (context, state) {
        Logger.log(tag, message: 'state: $state');
        QueueTerminalModel? terminal;
        if (state is TerminalOneLoadedState){
          terminal = state.terminal;
          _nameController.text = terminal.name??'';
        } else if (state is TerminalSuccessState){
          _messages.value = [S.of(context).success];
        } else if (state is TerminalErrorState){
          _errors.value = [state.error.data?.title??''];
        } else if (state is TerminalMissingBizState){
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
                      title: S.of(context).terminalForm, back: () {
                    _messages.value = [];
                    _errors.value = [];
                    _nameController.clear();
                    _departmentSelected.value =
                        QueueDepartmentModel(key: uuid.v4());
                    _terminalSelected.value =
                        QueueTerminalModel(key: uuid.v4());
                    _action.value = ActionPage.list;
                    context.read<TerminalBloc>().add(TerminalLoadAllEvent());
                  }, save: () async {
                    Logger.log(tag, message: '_saveOrUpdate---');
                    _messages.value = [];
                    _errors.value = [];
                    await _saveOrUpdate(terminal);
                  }),
                  ErrorBoxWidget(errors: _errors, width: width),
                  MsgBoxWidget(messages: _messages, width: width),
                  BlocBuilder<DepartmentBloc, DepartmentState>(
                    builder: (context, state) {
                      Logger.log(tag, message: 'state: $state');
                      List<QueueDepartmentModel> depList = [];
                      if (state is DepartmentLoadedState){
                        depList = state.departments;
                      } 
                      QueueDepartmentModel? selected = depList.singleWhereOrNull((e) => e.id==terminal?.queueDepartment?.id);
                      if (selected!=null) {
                        _departmentSelected.value = selected;
                      }
                      return Column(
                        children: [
                          DropdownButtonFormField<
                              QueueDepartmentModel>(
                            hint: Text(
                                S.of(context).selectDepartment),
                            items: depList
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e.name ?? ''),
                                    ))
                                .toList(),
                            isExpanded: true,
                            value: (selected?.id == null)
                                ? null
                                : selected,
                            validator: (value) =>
                                ValidateUtils.validateNotEmpty(
                                    value?.name),
                            decoration:
                                DecoratorUtils.dropdownDecoration(
                                    prefixIcon:
                                        CupertinoIcons.bookmark),
                            onChanged: (value) {
                              if (value != null) {
                                _departmentSelected.value = value;
                              }
                            },
                          ),
                          Constants.divider,
                          ValueListenableBuilder(
                            valueListenable: _departmentSelected,
                            builder: (context, QueueDepartmentModel departmentSelected, _) {
                              return TextFormField(
                                controller: _nameController,
                                enabled: departmentSelected.id != null,
                                textAlignVertical:
                                    TextAlignVertical.center,
                                textCapitalization:
                                    TextCapitalization.words,
                                maxLength: 10,
                                decoration:
                                    DecoratorUtils.inputDecoration(
                                        S.of(context).terminal,
                                        prefixIcon:
                                            CupertinoIcons.star,
                                        suffixIcon:
                                            CupertinoIcons.xmark,
                                        clear: () =>
                                            _nameController.clear()),
                                validator: (value) => ValidateUtils
                                    .validateStringMinMax(value, 3,
                                        10, S.of(context).department),
                              );
                            }
                          ),
                          Constants.divider,
                        ],
                      );
                      }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _saveOrUpdate(QueueTerminalModel? terminal) async {
    QueueDepartmentModel department = terminal?.queueDepartment?? _departmentSelected.value;
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text.trim();
      context.read<TerminalBloc>().add(
        TerminalSaveOrUpdateEvent(
          id: terminal?.id,
          name: name, 
          department: department
        )
      );
    }
  }
}
