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

import 'dart:async';

import 'package:admin/logger.dart';
import 'package:collection/collection.dart';
import 'package:common/bloc/agent_bloc.dart';
import 'package:common/bloc/biz_bloc.dart';
import 'package:common/bloc/department_bloc.dart';
import 'package:common/bloc/terminal_bloc.dart';
import 'package:common/generated/l10n.dart';
import 'package:common/locator.dart';
import 'package:common/models/account_model.dart';
import 'package:common/models/agent_model.dart';
import 'package:common/models/profile_biz_model.dart';
import 'package:common/models/queue_department_model.dart';
import 'package:common/models/queue_terminal_model.dart';
import 'package:common/services/rest_connect_service.dart';
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

class AgentPage extends StatefulWidget {
  final SharedPreferences prefs;
  final AgentModel? agent;
  const AgentPage({super.key, required this.prefs, this.agent});

  @override
  State<AgentPage> createState() => _AgentPageState();
}

class _AgentPageState extends State<AgentPage> {
  static const String tag = 'AgentPage';
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();

  final ValueNotifier<ActionPage> _action = ValueNotifier(ActionPage.list);
  final ValueNotifier<AgentModel> _agentSelected = ValueNotifier(AgentModel());
  final ValueNotifier<bool> _obscurePassword = ValueNotifier(true);
  final ValueNotifier<bool> _obscureConfirm = ValueNotifier(true);
  final ValueNotifier<QueueDepartmentModel> _departmentSelected =
      ValueNotifier(QueueDepartmentModel());
  final ValueNotifier<QueueTerminalModel> _terminalSelected =
      ValueNotifier(QueueTerminalModel());
  final ValueNotifier<List<String>> _errors = ValueNotifier([]);
  final ValueNotifier<List<String>> _messages = ValueNotifier([]);
  final ValueNotifier<AccountModel> _account = ValueNotifier(AccountModel());
  final RestConnectService restConnectService = locator<RestConnectService>();

  List<AgentModel>? _agentList;
  AgentModel? _agent;
  ProfileBizModel? _biz;

  @override
  void initState() {
    super.initState();
    _initialize(widget.agent);
  }

  Future<void> _initialize(AgentModel? agent) async {
    _errors.value = [];
    _messages.value = [];
    int? id = agent?.id;
    if (agent != null && id != null) {
      context.read<DepartmentBloc>().add(DepartmentLoadAllEvent(enable: true));
      context.read<BizBloc>().add(BizLoadOneEvent());
      context.read<AgentBloc>().add(AgentLoadOneEvent(id: id));
    } else {
      context.read<AgentBloc>().add(AgentLoadAllEvent());
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _action.dispose();
    _agentSelected.dispose();
    _obscurePassword.dispose();
    _obscureConfirm.dispose();
    _departmentSelected.dispose();
    _terminalSelected.dispose();
    _errors.dispose();
    _messages.dispose();
    _account.dispose();
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
            w = _buildAgentList();
          } else if (action == ActionPage.newItem) {
            w = _buildNewAgentForm();
          } else {
            w = const SizedBox();
          }
          return w;
        });
  }

  Widget _buildAgentList() {
    TextStyle? style = Theme.of(context).textTheme.headlineSmall;
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    if (width > ScreenProp.widthPhoneScreenLimit) {
      width = ScreenProp.widthPhoneScreenLimit;
    }
    return BlocBuilder<BizBloc, BizState>(
      builder: (context, stateBiz) {
        if (stateBiz is BizOneLoadedState){
          _biz = stateBiz.biz;
        }
        return BlocBuilder<AgentBloc, AgentState>(builder: (context, state) {
          Logger.log(tag, message: 'state: $state');
          if (state is AgentLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AgentLoadedState) {
            _agentList = state.agents;
          } else if (state is AgentSuccessState) {
            _messages.value = [S.of(context).success];
          } else if (state is AgentErrorState) {
            _errors.value = [state.error.data?.title??''];
          } else if (state is AgentMissingBizState) {
            return NoData(message: S.of(context).missingBusinessProfile);
          }
          return SizedBox(
              width: width,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(S.of(context).agentList, style: style),
                      IconButton.filled(
                        icon: const Icon(CupertinoIcons.add_circled_solid),
                        onPressed: () {
                          int agentLen = _agentList?.length ?? 0;
                          int bizLevel = _biz?.bizLevel ?? 0;
                          if (agentLen > bizLevel) {
                            _messages.value = [S.of(context).needUpgradeYourSubscription];
                            return;
                          }
                          _agent = null;
                          _usernameController.clear();
                          _agentSelected.value = AgentModel();
                          _terminalSelected.value = QueueTerminalModel();
                          _departmentSelected.value = QueueDepartmentModel();
                          _action.value = ActionPage.newItem;
                        },
                      ),
                    ],
                  ),
                ),
                if (_agentList == null || _agentList?.isEmpty == true) ...[
                  const Expanded(child: NoData()),
                ] else ...[
                  Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                    children: [
                      for (AgentModel agent in _agentList ?? []) ...[
                        _buildAgentItem(agent),
                      ],
                    ],
                  )))
                ]
              ]));
        });
      },
    );
  }

  Widget _buildAgentItem(AgentModel agent) {
    TextStyle? style = Theme.of(context).textTheme.headlineSmall;
    TextStyle? styleActivated =
        Theme.of(context).textTheme.bodySmall?.apply(color: Colors.white);
    return ValueListenableBuilder(
        valueListenable: _agentSelected,
        builder: (context, AgentModel selected, _) {
          if (selected.id == agent.id) {
            agent = selected;
          }
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              shape: const ContinuousRectangleBorder(
                  side: BorderSide(color: Colors.grey)),
              leading: CupertinoSwitch(
                  value: agent.enable ?? false,
                  onChanged: (value) async {
                    context
                        .read<AgentBloc>()
                        .add(AgentEnableEvent(agent: agent, enable: value));
                  }),
              title: Text(agent.login ?? '', style: style),
              trailing: IconButton(
                icon: const Icon(CupertinoIcons.trash),
                onPressed: () async {
                  context.read<AgentBloc>().add(AgentRemoveEvent(agent: agent));
                },
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Text(agent.email ?? ''),
                        const SizedBox(width: 4),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 12),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border:
                                  Border.all(width: 1.0, color: Colors.white),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6)),
                              color: (agent.account?.activated == true)
                                  ? Colors.green
                                  : Colors.blue,
                            ),
                            child: Text(
                                (agent.account?.activated == true)
                                    ? S.of(context).activated.toUpperCase()
                                    : S.of(context).deactivated.toUpperCase(),
                                style: styleActivated)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildDepartmentChip(agent),
                        const SizedBox(width: 8),
                        _buildTerminalChip(agent),
                      ],
                    ),
                  ),
                ],
              ),
              onTap: () async {
                await _initialize(agent);
                _action.value = ActionPage.newItem;
              },
            ),
          );
        });
  }

  Widget _buildDepartmentChip(AgentModel agent) {
    final dep = agent.queueDepartment;
    if (dep == null) return const SizedBox();
    return ChoiceChip(
      label: Text(dep.name ?? ''),
      selected: false,
      avatar: const Icon(CupertinoIcons.bookmark),
    );
  }

  Widget _buildTerminalChip(AgentModel agent) {
    final ter = agent.queueTerminal;
    if (ter == null) return const SizedBox();
    return ChoiceChip(
      label: Text(ter.name ?? ''),
      selected: false,
      avatar: const Icon(CupertinoIcons.star),
    );
  }

  Widget _buildNewAgentForm() {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    if (width > ScreenProp.widthPhoneScreenLimit) {
      width = ScreenProp.widthPhoneScreenLimit;
    }
    return BlocBuilder<AgentBloc, AgentState>(
      builder: (context, state) {
        if (state is AgentLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AgentOneLoadedState) {
          _agent = state.agent;
          final login = state.agent.login;
          final department = state.agent.queueDepartment;
          final terminal = state.agent.queueTerminal;
          _usernameController.text = login ?? '';
          _departmentSelected.value = department ?? _departmentSelected.value;
          _terminalSelected.value = terminal ?? _terminalSelected.value;
          if (department != null) {
            context
                .read<TerminalBloc>()
                .add(TerminalLoadByDepartmentEvent(department: department));
          }
        } else if (state is AgentSuccessState) {
          _messages.value = [S.of(context).success];
        } else if (state is AgentErrorState) {          
          _errors.value = [state.error.data?.title??''];
        } else if (state is AgentMissingBizState) {
          return NoData(message: S.of(context).missingBusinessProfile);
        } else if (state is AgentExistState) {
          _messages.value = [S.of(context).existAgentForDepartmentAndTerminal];
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
                            title: S.of(context).agentForm, back: () {
                          _messages.value = [];
                          _errors.value = [];
                          _usernameController.clear();
                          _departmentSelected.value = QueueDepartmentModel();
                          _terminalSelected.value = QueueTerminalModel();
                          _action.value = ActionPage.list;
                          context.read<AgentBloc>().add(AgentLoadAllEvent());
                        }, save: () async {
                          _messages.value = [];
                          _errors.value = [];
                          await _saveOrUpdate();
                        }),
                        ErrorBoxWidget(errors: _errors, width: width),
                        MsgBoxWidget(messages: _messages, width: width),
                        BlocBuilder<DepartmentBloc, DepartmentState>(
                            builder: (context, state) {
                          List<QueueDepartmentModel>? listDep;
                          if (state is DepartmentLoadedState) {
                            listDep = state.departments;
                          }
                          return ValueListenableBuilder(
                              valueListenable: _departmentSelected,
                              builder:
                                  (context, QueueDepartmentModel selected, _) {
                                return Column(
                                  children: [
                                    DropdownButtonFormField<
                                        QueueDepartmentModel>(
                                      hint:
                                          Text(S.of(context).selectDepartment),
                                      items: listDep
                                              ?.map((e) => DropdownMenuItem(
                                                    value: e,
                                                    child: Text(e.name ?? ''),
                                                  ))
                                              .toList() ??
                                          [],
                                      isExpanded: true,
                                      value: listDep?.singleWhereOrNull(
                                          (e) => e.id == selected.id),
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
                                          context.read<TerminalBloc>().add(
                                              TerminalLoadByDepartmentEvent(
                                                  department: value));
                                        }
                                      },
                                    ),
                                    Constants.divider,
                                    BlocBuilder<TerminalBloc, TerminalState>(
                                        builder: (context, state) {
                                      List<QueueTerminalModel>? listTer;
                                      if (state is TerminalLoadedState) {
                                        listTer = state.terminals;
                                      }

                                      return ValueListenableBuilder(
                                        valueListenable: _terminalSelected,
                                        builder: (context,
                                            QueueTerminalModel selectedTer, _) {
                                          return DropdownButtonFormField<
                                              QueueTerminalModel>(
                                            hint: Text(
                                                S.of(context).selectTerminal),
                                            items: listTer
                                                    ?.map((e) =>
                                                        DropdownMenuItem(
                                                          key: ValueKey(e.id),
                                                          value: e,
                                                          child: Text(
                                                              e.name ?? ''),
                                                        ))
                                                    .toList() ??
                                                [],
                                            isExpanded: true,
                                            value: listTer?.singleWhereOrNull(
                                                (e) => e.id == selectedTer.id),
                                            validator: (value) =>
                                                ValidateUtils.validateNotEmpty(
                                                    value?.name),
                                            decoration: DecoratorUtils
                                                .dropdownDecoration(
                                                    prefixIcon:
                                                        CupertinoIcons.star),
                                            onChanged: (value) {
                                              if (value != null) {
                                                _terminalSelected.value = value;
                                              }
                                            },
                                          );
                                        },
                                      );
                                    }),
                                    Constants.divider,
                                    _buildAgentDetailForm(),
                                  ],
                                );
                              });
                        }),
                      ]),
                )));
      },
    );
  }

  Widget _buildAgentDetailForm() {
    return ValueListenableBuilder(
        valueListenable: _terminalSelected,
        builder: (context, QueueTerminalModel selectedTer, _) {
          return Column(
            children: [
              TextFormField(
                controller: _usernameController,
                readOnly: _agent != null && selectedTer.id != null,
                enabled: _agent == null && selectedTer.id != null,
                textCapitalization: TextCapitalization.none,
                maxLength: 20,
                validator: (value) => ValidateUtils.validateStringMinMax(
                    value, 5, 20, S.of(context).username),
                decoration: DecoratorUtils.inputDecoration(
                  S.of(context).username,
                  prefixIcon: CupertinoIcons.person,
                  suffixIcon: CupertinoIcons.xmark,
                  clear: () async {
                    _usernameController.clear();
                  },
                ),
              ),
            ],
          );
        });
  }

  Future<void> _saveOrUpdate() async {
    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text.trim().toLowerCase();
      final dep = _departmentSelected.value;
      final ter = _terminalSelected.value;

      context.read<AgentBloc>().add(AgentSaveOrUpdateEvent(
          login: username,
          enable: false,
          queueDepartment: dep,
          queueTerminal: ter));
    }
  }
}
