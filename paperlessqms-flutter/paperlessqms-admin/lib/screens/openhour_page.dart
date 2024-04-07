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
import 'package:common/bloc/openhour_bloc.dart';
import 'package:common/generated/l10n.dart';
import 'package:common/models/openhour_model.dart';
import 'package:common/utils/constants.dart';
import 'package:common/utils/functions.dart';
import 'package:common/utils/no_data.dart';
import 'package:common/widgets/error_box_widget.dart';
import 'package:common/widgets/msg_box_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OpenhourPage extends StatefulWidget {
  final SharedPreferences prefs;
  final OpenhourModel? openhour;
  const OpenhourPage({super.key, required this.prefs, this.openhour});

  @override
  State<OpenhourPage> createState() => _OpenhourPageState();
}

class _OpenhourPageState extends State<OpenhourPage> {
  static const String tag = 'OpenhourPage';
  final _formKey = GlobalKey<FormState>();

  final ValueNotifier<ActionPage> _action = ValueNotifier(ActionPage.list);
  final ValueNotifier<List<String>> _errors = ValueNotifier([]);
  final ValueNotifier<List<String>> _messages = ValueNotifier([]);
  final ValueNotifier<OpenhourModel> _openhourSelected =
      ValueNotifier(OpenhourModel());
  final ValueNotifier<int> _selectedDay = ValueNotifier(0);
  final ValueNotifier<String> _start = ValueNotifier('...');
  final ValueNotifier<String> _end = ValueNotifier('...');

  List<OpenhourModel>? _openhourList;
  OpenhourModel? _openhour;
  DateTime? _startTime;
  DateTime? _endTime;

  @override
  void initState() {
    super.initState();
    _initialize(widget.openhour);
  }

  Future<void> _initialize(OpenhourModel? openhour) async {
    _errors.value = [];
    _messages.value = [];
    int? id = openhour?.id;
    if (openhour != null && id != null) {
      context.read<OpenhourBloc>().add(OpenhourLoadOneEvent(id: id));
    } else {
      context.read<OpenhourBloc>().add(OpenhourLoadAllEvent());
    }
  }

  @override
  void dispose() {
    _action.dispose();
    _errors.dispose();
    _messages.dispose();
    _openhourSelected.dispose();
    _selectedDay.dispose();
    _start.dispose();
    _end.dispose();
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
            w = _buildOpenhourList();
          } else if (action == ActionPage.newItem) {
            w = _buildNewOpenhourForm();
          } else {
            w = const SizedBox();
          }
          return w;
        });
  }

  Widget _buildOpenhourList() {
    TextStyle? style = Theme.of(context).textTheme.headlineSmall;
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    if (width > ScreenProp.widthPhoneScreenLimit) {
      width = ScreenProp.widthPhoneScreenLimit;
    }
    return BlocBuilder<OpenhourBloc, OpenhourState>(builder: (context, state) {
      Logger.log(tag, message: 'state: $state');
      if (state is OpenhourLoadingState) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is OpenhourLoadedState) {
        _openhourList = state.openhours;
      } else if (state is OpenhourSuccessState) {
        _messages.value = [S.of(context).success];
      } else if (state is OpenhourErrorState) {
        _errors.value = [state.error.data?.title??''];
      } else if (state is OpenhourMissingBizState) {
        return NoData(message: S.of(context).missingBusinessProfile);
      }
      _openhourList?.sortAscByNullable<num>((e) => e.dayNum);
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
                  Text(S.of(context).openingHours, style: style),
                  IconButton.filled(
                    icon: const Icon(CupertinoIcons.add_circled_solid),
                    onPressed: () {
                      _openhour = null;
                      _startTime = null;
                      _endTime = null;
                      _selectedDay.value = 0;
                      _start.value = '...';
                      _end.value = '...';
                      _action.value = ActionPage.newItem;
                    },
                  ),
                ],
              ),
            ),
            if (_openhourList == null || _openhourList?.isEmpty == true) ...[
              const Expanded(child: NoData()),
            ] else ...[
              Expanded(
                flex: 10,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (OpenhourModel oh in _openhourList ?? []) ...[
                        _buildItem(oh),
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

  Widget _buildItem(oh) {
    TextStyle? style = Theme.of(context).textTheme.headlineSmall;
    return ValueListenableBuilder(
        valueListenable: _openhourSelected,
        builder: (context, OpenhourModel selected, _) {
          if (selected.id == oh.id) {
            oh = selected;
          }
          String start = '${oh.startHour}:${oh.startMin}';
          String end = '${oh.endHour}:${oh.endMin}';
          int? dayNum = oh.dayNum;
          String dayName = (dayNum != null) ? DayMap.long[dayNum] ?? '' : '';
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              shape: const ContinuousRectangleBorder(
                  side: BorderSide(color: Colors.grey)),
              leading: CupertinoSwitch(
                  value: oh.enable ?? false,
                  onChanged: (value) async {
                    context.read<OpenhourBloc>().add(OpenhourEnableEvent(openhour: oh, enable: value));
                  }),
              title: Text('$start to $end', style: style),
              subtitle: Text(dayName, style: style),
              trailing: IconButton(
                icon: const Icon(CupertinoIcons.trash),
                onPressed: () async {
                  _openhour = null;
                  _startTime = null;
                  _endTime = null;
                  _selectedDay.value = 0;
                  context
                      .read<OpenhourBloc>()
                      .add(OpenhourRemoveEvent(openhour: oh));
                },
              ),
              onTap: () async {
                await _initialize(oh);
                _action.value = ActionPage.newItem;
              },
            ),
          );
        });
  }

  Widget _buildNewOpenhourForm() {
    TextStyle? styleLarge = Theme.of(context).textTheme.headlineLarge;
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    if (width > ScreenProp.widthPhoneScreenLimit) {
      width = ScreenProp.widthPhoneScreenLimit;
    }
    return BlocBuilder<OpenhourBloc, OpenhourState>(
      builder: (context, state) {
        Logger.log(tag, message: 'state: $state');
        if (state is OpenhourLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is OpenhourOneLoadedState) {
          _openhour = state.openhour;
          DateTime now = DateTime.now();
          _selectedDay.value = _openhour?.dayNum?? 0;
          int? startHour = _openhour?.startHour;
          int? startMin = _openhour?.startMin;
          int? endHour = _openhour?.endHour;
          int? endMin = _openhour?.endMin;
          if (startHour!=null && startMin!=null &&
              endHour!=null && endMin!=null){
            _startTime = DateTime(now.year, now.month, now.day, startHour, startMin);
            _endTime = DateTime(now.year, now.month, now.day, endHour, endMin);
          }
          _start.value = (_startTime != null)
              ? '${_startTime?.hour}:${_startTime?.minute}'
              : '...';
          _end.value =
              (_endTime != null) ? '${_endTime?.hour}:${_endTime?.minute}' : '...';
        } else if (state is OpenhourSuccessState) {
          _messages.value = [S.of(context).success];
        } else if (state is OpenhourErrorState) {
          _errors.value = [state.error.data?.title??''];
        } else if (state is OpenhourMissingBizState){
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
                      title: S.of(context).openHourForm, back: () {
                    _messages.value = [];
                    _errors.value = [];
                    _action.value = ActionPage.list;
                    context.read<OpenhourBloc>().add(OpenhourLoadAllEvent());
                  }, save: () async {
                    _messages.value = [];
                    _errors.value = [];
                    await _saveOrUpdate(_openhour);
                  }),
                  ErrorBoxWidget(errors: _errors, width: width),
                  MsgBoxWidget(messages: _messages, width: width),
                  Constants.divider,
                  ValueListenableBuilder(
                    valueListenable: _start,
                    builder: (context, String start, _) {
                      return ListTile(
                        title: Text(S.of(context).startTime, style: styleLarge),
                        trailing: Text(start, style: styleLarge),
                        onTap: () {
                          Utils.showDialog(
                              context,
                              CupertinoDatePicker(
                                initialDateTime: _startTime,
                                mode: CupertinoDatePickerMode.time,
                                use24hFormat: true,
                                onDateTimeChanged: (DateTime newTime) {
                                  _startTime = newTime;
                                  _start.value = '${newTime.hour}:${newTime.minute}';
                                },
                              ));
                        },
                      );
                    }
                  ),
                  Constants.divider,
                  ValueListenableBuilder(
                    valueListenable: _end,
                    builder: (context, String end, _) {
                      return ListTile(
                        title: Text(S.of(context).endTime, style: styleLarge),
                        trailing: Text(end, style: styleLarge),
                        onTap: () {
                          Utils.showDialog(
                              context,
                              CupertinoDatePicker(
                                initialDateTime: _endTime,
                                mode: CupertinoDatePickerMode.time,
                                use24hFormat: true,
                                onDateTimeChanged: (DateTime newTime) {
                                  _endTime = newTime;
                                  _end.value = '${newTime.hour}:${newTime.minute}';
                                },
                              ));
                        },
                      );
                    }
                  ),
                  Constants.divider,
                  ListTile(
                    title: Text(S.of(context).selectDay, style: styleLarge),
                    subtitle: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ValueListenableBuilder(
                        valueListenable: _selectedDay,
                        builder: (context, int selectedDay, _) {
                          return Row(children: [
                            for (var entry in DayMap.short.entries) ...[
                              _buildChipItem(entry, selectedDay),
                              const SizedBox(width: 6),
                            ],
                          ]);
                        }
                      ),
                    ),
                  ),
                  Constants.divider,
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildChipItem(MapEntry entry, int selectedDay) {
    bool b =
        ((_openhourList?.indexWhere((e) => e.dayNum == entry.key) ?? -1) >= 0);
    if (b == false ||
        selectedDay == entry.key ||
        _openhour?.dayNum == entry.key) {
      return ActionChip(
        label: Text(entry.value,
            style: TextStyle(
                color: (selectedDay == entry.key) ? Colors.white : null)),
        backgroundColor: (selectedDay == entry.key) ? Colors.blue : null,
        onPressed: () {
          _selectedDay.value = entry.key;
          setState(() {});
        },
      );
    } else {
      return Text(entry.value);
    }
  }

  Future<void> _saveOrUpdate(OpenhourModel? openhour) async {
    DateTime? startTime = _startTime;
    DateTime? endTime = _endTime;
    int day = _selectedDay.value;
    if (startTime == null || endTime == null) {
      Utils.overlayWarnMessage(
          warns: [S.of(context).selectTimeAndDay], notifier: _errors);
      return;
    }
    int? id = openhour?.id;
    context.read<OpenhourBloc>().add(OpenhourSaveOrUpdateEvent(
          id: id,
          startHour: startTime.hour,
          startMin: startTime.minute,
          endHour: endTime.hour,
          endMin: endTime.minute,
          dayNum: day,
          enable: false,
        ));
  }
}
