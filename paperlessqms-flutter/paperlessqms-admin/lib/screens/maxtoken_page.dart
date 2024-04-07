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
import 'package:common/bloc/maxtoken_bloc.dart';
import 'package:common/generated/l10n.dart';
import 'package:common/models/maxtoken_model.dart';
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

class MaxtokenPage extends StatefulWidget {
  final SharedPreferences prefs;
  final MaxtokenModel? maxtoken;
  const MaxtokenPage({super.key, required this.prefs, this.maxtoken});

  @override
  State<MaxtokenPage> createState() => _MaxtokenPageState();
}

class _MaxtokenPageState extends State<MaxtokenPage> {
  static const String tag = 'MaxtokenPage';
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _maxTokenController = TextEditingController();

  final ValueNotifier<ActionPage> _action = ValueNotifier(ActionPage.list);
  final ValueNotifier<List<String>> _errors = ValueNotifier([]);
  final ValueNotifier<List<String>> _messages = ValueNotifier([]);

  List<MaxtokenModel>? _maxtokenList;
  MaxtokenModel? _maxtoken;
  int? _selectedDay;

  @override
  void initState() {
    super.initState();
    _initialize(widget.maxtoken);
  }

  Future<void> _initialize(MaxtokenModel? maxtoken) async {
    _errors.value = [];
    _messages.value = [];
    int? id = maxtoken?.id;
    if (maxtoken != null && id != null) {
      context.read<MaxtokenBloc>().add(MaxtokenLoadOneEvent(id: id));
    } else {
      context.read<MaxtokenBloc>().add(MaxtokenLoadAllEvent());
    }
  }

  @override
  void dispose() {
    _maxTokenController.dispose();
    _action.dispose();
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
    return BlocBuilder<MaxtokenBloc, MaxtokenState>(builder: (context, state) {
      Logger.log(tag, message: 'state: $state');
      if (state is MaxtokenLoadingState) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is MaxtokenLoadedState) {
        _maxtokenList = state.maxtokens;
      } else if (state is MaxtokenSuccessState) {
        _messages.value = [S.of(context).success];
      } else if (state is MaxtokenErrorState) {
        _errors.value = [state.error.data?.title??''];
      } else if (state is MaxtokenMissingBizState) {
        return NoData(message: S.of(context).missingBusinessProfile);
      }
      _maxtokenList?.sortAscByNullable<num>((e) => e.dayNum);
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
                  Text(S.of(context).maxTokenList, style: style),
                  IconButton.filled(
                    icon: const Icon(CupertinoIcons.add_circled_solid),
                    onPressed: () {
                      _maxtoken = null;
                      _maxTokenController.clear();
                      _selectedDay = null;
                      _action.value = ActionPage.newItem;
                    },
                  ),
                ],
              ),
            ),
            if (_maxtokenList == null || _maxtokenList?.isEmpty == true) ...[
              const Expanded(child: NoData()),
            ] else ...[
              Expanded(
                flex: 10,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (MaxtokenModel mt in _maxtokenList ?? []) ...[
                        _buildItem(mt),
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

  Widget _buildItem(MaxtokenModel mt) {
    TextStyle? style = Theme.of(context).textTheme.headlineSmall;
    int? dayNum = mt.dayNum;
    String dayName = (dayNum != null) ? DayMap.long[dayNum] ?? '' : '';
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        shape: const ContinuousRectangleBorder(
            side: BorderSide(color: Colors.grey)),
        title: Text('MAX count: ${mt.maxToken}', style: style),
        subtitle: Text(dayName, style: style),
        trailing: IconButton(
          icon: const Icon(CupertinoIcons.trash),
          onPressed: () async {
            _maxtoken = null;
            _selectedDay = null;
            _maxTokenController.clear();
            context.read<MaxtokenBloc>().add(MaxtokenRemoveEvent(maxtoken: mt));
          },
        ),
        onTap: () async {
          await _initialize(mt);
          _action.value = ActionPage.newItem;
        },
      ),
    );
  }

  Widget _buildNewDepartmentForm() {
    TextStyle? styleLarge = Theme.of(context).textTheme.headlineLarge;
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    if (width > ScreenProp.widthPhoneScreenLimit) {
      width = ScreenProp.widthPhoneScreenLimit;
    }
    return BlocBuilder<MaxtokenBloc, MaxtokenState>(
      builder: (context, state) {
        Logger.log(tag, message: 'state: $state');
        if (state is MaxtokenLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MaxtokenOneLoadedState) {
          _maxtoken = state.maxtoken;
          _maxTokenController.text = '${_maxtoken?.maxToken ?? ''}';
          _selectedDay = _maxtoken?.dayNum;
        } else if (state is MaxtokenSuccessState) {
          _messages.value = [S.of(context).success];
        } else if (state is MaxtokenErrorState) {
          _errors.value = [state.error.data?.title??''];
        } else if (state is MaxtokenMissingBizState){
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
                      title: S.of(context).maxTokenForm, back: () {
                    _messages.value = [];
                    _errors.value = [];
                    _action.value = ActionPage.list;
                    context.read<MaxtokenBloc>().add(MaxtokenLoadAllEvent());
                  }, save: () async {
                    _messages.value = [];
                    _errors.value = [];
                    await _saveOrUpdate(_maxtoken);
                  }),
                  ErrorBoxWidget(errors: _errors, width: width),
                  MsgBoxWidget(messages: _messages, width: width),
                  Constants.divider,
                  TextFormField(
                    controller: _maxTokenController,
                    textAlignVertical: TextAlignVertical.center,
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: false, decimal: false),
                    maxLength: 10,
                    decoration: DecoratorUtils.inputDecoration(
                        S.of(context).maxCountTokenNumber,
                        prefixIcon: CupertinoIcons.tray_full,
                        suffixIcon: CupertinoIcons.xmark,
                        clear: () => _maxTokenController.clear()),
                    validator: (value) => ValidateUtils.validateDigitMinMax(
                        value, 1, double.maxFinite.toInt()),
                  ),
                  Constants.divider,
                  ListTile(
                    title: Text(S.of(context).selectDay, style: styleLarge),
                    subtitle: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: [
                        for (var entry in DayMap.short.entries) ...[
                          _buildChipItem(entry),
                          const SizedBox(width: 6),
                        ],
                      ]),
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

  Widget _buildChipItem(MapEntry entry) {
    bool b =
        ((_maxtokenList?.indexWhere((e) => e.dayNum == entry.key) ?? -1) >= 0);
    if (b == false ||
        _selectedDay == entry.key ||
        _maxtoken?.dayNum == entry.key) {
      return ActionChip(
        label: Text(entry.value,
            style: TextStyle(
                color: (_selectedDay == entry.key) ? Colors.white : null)),
        backgroundColor: (_selectedDay == entry.key) ? Colors.blue : null,
        onPressed: () {
          _selectedDay = entry.key;
          setState(() {});
        },
      );
    } else {
      return Text(entry.value);
    }
  }

  Future<void> _saveOrUpdate(MaxtokenModel? maxtoken) async {
    int? day = _selectedDay;
    if (day == null) {
      _errors.value = [S.of(context).selectDay];
      return;
    }
    if (_formKey.currentState!.validate()) {
      int max = int.tryParse(_maxTokenController.text.trim()) ?? 0;
      context.read<MaxtokenBloc>().add(MaxtokenSaveOrUpdateEvent(id: maxtoken?.id, dayNum: day, maxToken: max));
    }
  }
}
