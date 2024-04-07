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
import 'dart:convert';

import 'package:client/logger.dart';
import 'package:common/bloc/maxtoken_bloc.dart';
import 'package:common/bloc/openhour_bloc.dart';
import 'package:common/generated/l10n.dart';
import 'package:common/models/maxtoken_model.dart';
import 'package:common/models/openhour_model.dart';
import 'package:common/models/profile_biz_model.dart';
import 'package:common/utils/constants.dart';
import 'package:common/utils/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BizScreen extends StatefulWidget {
  final SharedPreferences prefs;
  final ProfileBizModel biz;
  const BizScreen({super.key, required this.prefs, required this.biz});

  @override
  State<BizScreen> createState() => _BizScreenState();
}

class _BizScreenState extends State<BizScreen> {
  static const String tag = 'BizScreen';

  ProfileBizModel? _biz;
  List<OpenhourModel>? _openList;
  List<MaxtokenModel>? _maxList;
  final Map<String, OpenhourModel?> _hours = {};
  final Map<String, MaxtokenModel?> _maxs = {};

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    Logger.log(tag, message: '_initialize---');
    context
        .read<OpenhourBloc>()
        .add(OpenhourByBizEvent(biz: widget.biz, enable: true));
    context
        .read<MaxtokenBloc>()
        .add(MaxtokenByBizEvent(biz: widget.biz, enable: true));
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? styleHeadline = Theme.of(context).textTheme.headlineMedium;
    TextStyle? styleBody = Theme.of(context).textTheme.bodyMedium;
    TextStyle? styleEmpty = Theme.of(context)
        .textTheme
        .bodyMedium
        ?.apply(fontStyle: FontStyle.italic);
    String? email = _biz?.bizEmail;
    String? phone = _biz?.bizPhoneNumber;
    String? address = _biz?.bizAddress;
    String? website = _biz?.bizWebsite;
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    if (width > ScreenProp.widthPhoneScreenLimit) {
      width = ScreenProp.widthPhoneScreenLimit;
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(S.of(context).businessInfo),
      ),
      body: Center(
        child: Container(
          alignment: Alignment.topCenter,
          width: width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  leading: (_biz?.bizLogoBase64?.isNotEmpty == true)
                      ? Image.memory(base64Decode(_biz?.bizLogoBase64 ?? ''))
                      : Image.asset('assets/images/1024.png'),
                  title: Text(_biz?.bizName ?? '', style: styleHeadline),
                  subtitle: Text(_biz?.bizDesc ?? '', style: styleBody),
                ),
                Constants.divider,
                ListTile(
                  leading: const Icon(CupertinoIcons.envelope),
                  title: Text(S.of(context).email),
                  subtitle: (email != null && email.isNotEmpty == true)
                      ? Text(email, style: styleBody)
                      : Text('<${S.of(context).empty}>', style: styleEmpty),
                ),
                Constants.divider,
                ListTile(
                  leading: const Icon(CupertinoIcons.phone),
                  title: Text(S.of(context).phone),
                  subtitle: (phone != null && phone.isNotEmpty == true)
                      ? Text(phone, style: styleBody)
                      : Text('<${S.of(context).empty}>', style: styleEmpty),
                ),
                Constants.divider,
                ListTile(
                  leading: const Icon(CupertinoIcons.building_2_fill),
                  title: Text(S.of(context).address),
                  subtitle: (address != null && address.isNotEmpty == true)
                      ? Text(address, style: styleBody)
                      : Text('<${S.of(context).empty}>', style: styleEmpty),
                ),
                Constants.divider,
                ListTile(
                  leading: const Icon(CupertinoIcons.globe),
                  title: Text(S.of(context).webSite),
                  subtitle: (website != null && website.isNotEmpty == true)
                      ? Text(website, style: styleBody)
                      : Text('<${S.of(context).empty}>', style: styleEmpty),
                ),
                Constants.divider,
                Text(S.of(context).openingHours, style: styleHeadline),
                const SizedBox(height: 16),
                BlocBuilder<OpenhourBloc, OpenhourState>(
                  builder: (context, state) {
                    if (state is OpenhourLoadedState) {
                      _openList = state.openhours;
                      DayMap.short.forEach((key, value) {
                        _hours[value] = _openList?.singleWhere(
                            (e) => e.dayNum == key,
                            orElse: () => OpenhourModel());
                      });
                    }
                    return SizedBox(
                      width: 200,
                      child: Column(
                        children: [
                          for (MapEntry<String, OpenhourModel?> me
                              in _hours.entries) ...[
                            if (me.value?.id != null) ...[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(me.key),
                                  Text(
                                      '${me.value?.startHour}:${me.value?.startMin} to ${me.value?.endHour}:${me.value?.endMin}'),
                                ],
                              ),
                            ] else ...[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(me.key),
                                  Text('<${S.of(context).empty}>',
                                      style: styleEmpty),
                                ],
                              ),
                            ]
                          ]
                        ],
                      ),
                    );
                  },
                ),
                Constants.divider,
                Text(S.of(context).maxTokens, style: styleHeadline),
                const SizedBox(height: 16),
                BlocBuilder<MaxtokenBloc, MaxtokenState>(
                  builder: (context, state) {
                    if (state is MaxtokenLoadedState){
                      _maxList = state.maxtokens;
                      DayMap.short.forEach((key, value) {
                        _maxs[value] = _maxList?.singleWhere((e) => e.dayNum==key, orElse: ()=> MaxtokenModel());
                      });
                    }
                    return SizedBox(
                      width: 200,
                      child: Column(
                        children: [
                          for (MapEntry<String, MaxtokenModel?> me
                              in _maxs.entries) ...[
                            if (me.value?.id != null) ...[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(me.key),
                                  Text('${me.value?.maxToken}'),
                                ],
                              ),
                            ] else ...[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(me.key),
                                  Text('<${S.of(context).empty}>',
                                      style: styleEmpty),
                                ],
                              ),
                            ]
                          ]
                        ],
                      ),
                    );
                  },
                ),
                Constants.divider,
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: (_biz?.bizPhotoBase64?.isNotEmpty == true)
                      ? Image.memory(base64Decode(_biz?.bizPhotoBase64 ?? ''))
                      : const SizedBox(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
