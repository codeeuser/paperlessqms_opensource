// ignore_for_file: use_build_context_synchronously

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

import 'package:common/app_absorb.dart';
import 'package:common/bloc/biz_bloc.dart';
import 'package:common/generated/l10n.dart';
import 'package:common/models/profile_biz_model.dart';
import 'package:common/screens/login_screen.dart';
import 'package:common/utils/constants.dart';
import 'package:common/utils/functions.dart';
import 'package:common/utils/no_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiosk/logger.dart';
import 'package:kiosk/screens/biz_page.dart';
import 'package:kiosk/screens/department_page.dart';
import 'package:kiosk/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WayScreen extends StatefulWidget {
  final SharedPreferences prefs;
  const WayScreen({super.key, required this.prefs});

  @override
  State<WayScreen> createState() => _WayScreenState();
}

class _WayScreenState extends State<WayScreen> {
  static const String tag = 'WayScreen';

  final TextEditingController _searchBizController = TextEditingController();

  List<ProfileBizModel>? _bizs;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    Logger.log(tag, message: '_initialize---');
    Logger.sendCatcherError(tag, 'Test Exception', '');
    context.read<BizBloc>().add(BizLoadAllEvent(page: 0, pageSize: 10, sortBy: 'bizLevel,modifiedDate,desc', enable: true));
  }

  @override
  void dispose() {
    _searchBizController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    if (width>ScreenProp.widthPhoneScreenLimit){
      width = ScreenProp.widthPhoneScreenLimit;
    }
    TextStyle? styleLabelSmall = Theme.of(context).textTheme.labelSmall;
    return Scaffold(
      body: Consumer<AppAbsorb>(
        builder: (context, appAbsorb, _) {
          if (appAbsorb.recaptcha==false){
            return _buildLogoutButton();
          }
          return BlocBuilder<BizBloc, BizState>(
            builder: (context, state) {
              if (state is BizLoadedState){
                _bizs = state.bizs;
              }
              return Center(
                child: SizedBox(
                  width: width,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _searchBizController,
                            decoration: DecoratorUtils.inputDecoration(
                              S.of(context).search,
                              prefixIcon: CupertinoIcons.search,
                              suffixIcon: CupertinoIcons.xmark,
                              clear: () async{
                                _searchBizController.clear();
                                context.read<BizBloc>().add(
                                  BizLoadAllEvent(
                                    page: 0, pageSize: 10, sortBy: 'bizLevel,modifiedDate,desc', enable: true
                                  )
                                );
                              }  
                            ),
                            onChanged: (value) async{
                              if (value.length>=3){
                                context.read<BizBloc>().add(BizSearchEvent(text: value));
                              }
                              if (value.isEmpty){
                                context.read<BizBloc>().add(
                                  BizLoadAllEvent(
                                    page: 0, pageSize: 10, sortBy: 'bizLevel,modifiedDate,desc', enable: true
                                  )
                                );
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(S.of(context).selectOneOfTheItemsBelow, style: styleLabelSmall),
                        ),
                        for(ProfileBizModel biz in _bizs??[])...[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                            child: ListTile(
                              shape: const ContinuousRectangleBorder(side: BorderSide(color: Colors.grey)),
                              contentPadding: EdgeInsets.zero,
                              leading: ClipOval(
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  padding: const EdgeInsets.all(10.0),
                                  child: (biz.bizLogoBase64?.isNotEmpty==true)?
                                    Image.memory(base64Decode(biz.bizLogoBase64??'')):
                                    Image.asset('assets/images/1024.png'),
                                ),
                              ),
                              title: Text(biz.bizName??''),
                              trailing: IconButton(
                                icon: const Icon(CupertinoIcons.ellipsis_vertical_circle),
                                onPressed: (){
                                  Utils.pushPage(context, BizPage(prefs: widget.prefs, biz: biz), 'BizPage');
                                },
                              ),
                              onTap: (){
                                Utils.pushPage(context, DepartmentPage(prefs: widget.prefs, biz: biz), 'DepartmentPage');
                              },
                            ),
                          ),
                        ]
                      ],
                    ),
                  ),
                ),
              );
            }
          );
        }
      ),
    );
  }

  Widget _buildLogoutButton({String? message}){
    return Column(
      children: [
        NoData(message: message),
        const SizedBox(height: 16),
        ElevatedButton(
          child: Text(S.of(context).signout),
          onPressed: () async{
            await PrefsUtils.signout(context, widget.prefs);
            Utils.pushAndRemoveUntilPage(context, 
              LoginScreen(
                prefs: widget.prefs,
                appTitle: AppConstants.appTitle,
                w: WayScreen(prefs: widget.prefs),
                callback: (){
                  Logger.log(tag, message: 'LoginScreen Callback');          
                },  
              ),
            'LoginScreen');
          },
        ),
      ],
    );
  }
}