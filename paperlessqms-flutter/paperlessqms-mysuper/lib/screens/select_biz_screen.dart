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
import 'package:common/bloc/biz_bloc.dart';
import 'package:common/generated/l10n.dart';
import 'package:common/models/account_model.dart';
import 'package:common/models/profile_biz_model.dart';
import 'package:common/screens/login_screen.dart';
import 'package:common/utils/constants.dart';
import 'package:common/utils/functions.dart';
import 'package:common/utils/no_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysuper/logger.dart';
import 'package:mysuper/screens/way_screen.dart';
import 'package:mysuper/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectBizScreen extends StatefulWidget {
  final SharedPreferences prefs;
  const SelectBizScreen({super.key, required this.prefs});

  @override
  State<SelectBizScreen> createState() => _SelectBizScreenState();
}

class _SelectBizScreenState extends State<SelectBizScreen> {
  static const String tag = 'SelectBizScreen';

  List<ProfileBizModel>? _bizs;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    Logger.log(tag, message: '_initialize---');
    context.read<BizBloc>().add(BizLoadAllEvent(page: 0, pageSize: 100, sortBy: 'bizLevel,modifiedDate,desc'));
    // _bizRepository = BizRepository(context: context, prefs: widget.prefs);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _buildSelectContent(),
      ),
    );
  }

  Widget _buildSelectContent(){
    AccountModel? account = PrefsUtils.getAccount(widget.prefs);
    if (account==null){
      return _buildLogoutButton();
    }
    TextStyle? styleLarge = Theme.of(context).textTheme.bodyLarge;
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    if (width>ScreenProp.widthPhoneScreenLimit){
      width = ScreenProp.widthPhoneScreenLimit;
    }
    return BlocBuilder<BizBloc, BizState>(
      builder: (context, state) {
        if (state is BizLoadingState){
          return const Center(child: CircularProgressIndicator());
        } else if (state is BizLoadedState){
          _bizs = state.bizs;
        } else if (state is BizErrorState){
          return _buildLogoutButton(message: state.error.data?.title);
        }
        return Center(
          child: SizedBox(
            width: width,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(S.of(context).selectOneOfTheItemsBelow),
                  ),
                  if (_bizs==null || _bizs?.isEmpty==true)...[
                    _buildLogoutButton(),
                  ] else ...[
                    for(ProfileBizModel biz in _bizs??[])...[                    
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          shape: const ContinuousRectangleBorder(side: BorderSide(color: Colors.grey)),
                          leading: Text((biz.enable==true)? 'ENABLED': 'DISABLED'),
                          title: Text(biz.bizName??'', style: styleLarge),
                          onTap: (){
                            Utils.pushAndRemoveUntilPage(context, WayScreen(prefs: widget.prefs, biz: biz), 'WayScreen');
                          },
                        ),
                      ),
                    ],
                  ],
                ],
              ),
            ),
          ),
        );
      }
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
              w: SelectBizScreen(prefs: widget.prefs),
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