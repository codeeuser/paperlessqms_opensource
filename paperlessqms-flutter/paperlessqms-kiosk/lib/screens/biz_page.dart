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

import 'package:common/bloc/biz_bloc.dart';
import 'package:common/generated/l10n.dart';
import 'package:common/models/profile_biz_model.dart';
import 'package:common/utils/constants.dart';
import 'package:common/utils/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiosk/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BizPage extends StatefulWidget {
  final SharedPreferences prefs;
  final ProfileBizModel biz;
  const BizPage({super.key, required this.prefs, required this.biz});

  @override
  State<BizPage> createState() => _BizPageState();
}

class _BizPageState extends State<BizPage> {
  static const String tag = 'BizPage';

  ProfileBizModel? _biz;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    Logger.log(tag, message: '_initialize---');
    int? id = widget.biz.id;
    if (id != null) {
      context.read<BizBloc>().add(BizByIdEvent(id: id));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    if (width > ScreenProp.widthPhoneScreenLimit) {
      width = ScreenProp.widthPhoneScreenLimit;
    }
    TextStyle? styleHeadline = Theme.of(context).textTheme.headlineMedium;
    TextStyle? styleBody = Theme.of(context).textTheme.bodyMedium;
    TextStyle? styleEmpty = Theme.of(context)
        .textTheme
        .bodyMedium
        ?.apply(fontStyle: FontStyle.italic);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(S.of(context).businessInfo),
      ),
      body: BlocBuilder<BizBloc, BizState>(
        builder: (context, state) {
          if (state is BizOneLoadedState){
            _biz = state.biz;
          }
          String? email = _biz?.bizEmail;
          String? phone = _biz?.bizPhoneNumber;
          String? address = _biz?.bizAddress;
          String? website = _biz?.bizWebsite;
          return Center(
            child: SizedBox(
              width: width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      leading: (_biz?.bizLogoBase64?.isNotEmpty == true)
                          ? Image.memory(
                              base64Decode(_biz?.bizLogoBase64 ?? ''))
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
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: (_biz?.bizPhotoBase64?.isNotEmpty == true)
                          ? Image.memory(
                              base64Decode(_biz?.bizPhotoBase64 ?? ''))
                          : const SizedBox(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
