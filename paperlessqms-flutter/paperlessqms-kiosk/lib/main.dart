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
import 'dart:async';
import 'dart:convert';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:catcher_2/catcher_2.dart';
import 'package:common/app_theme.dart';
import 'package:common/bloc/account_bloc.dart';
import 'package:common/generated/l10n.dart';
import 'package:common/locator.dart';
import 'package:common/models/account_model.dart';
import 'package:common/screens/login_screen.dart';
import 'package:common/utils/constants.dart';
import 'package:common/utils/functions.dart';
import 'package:common/utils/no_data.dart';
import 'package:common/utils/overlay_support/overlay_state_finder.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ipwhois/ipwhois.dart';
import 'package:kiosk/logger.dart';
import 'package:kiosk/screens/way_screen.dart';
import 'package:kiosk/utils/constants.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';

final _applicationIconImage = Image.asset(
  'assets/images/1024.png',
);

void main() async{
    
  runZoned(() async {
    WidgetsFlutterBinding.ensureInitialized();

    SharedPreferences.setPrefix(AppConstants.appPrefix);
    final prefs = await SharedPreferences.getInstance();
  
    DateTime now = DateTime.now().toLocal();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    ReportMode reportMode = SilentReportMode();
    var optDebug = Catcher2Options(reportMode, [
      ConsoleHandler(
          enableApplicationParameters: false,
          enableDeviceParameters: false,
          enableCustomParameters: false,
        )
      ],
      customParameters: {
        'timeZoneOffset': now.timeZoneOffset.inHours.toString(),
        'timeZoneName': now.timeZoneName,
        'emailLogin': prefs.getString(Prefs.emailLogin),
        'appName': AppConstants.appTitle,
        'appVersion': '${packageInfo.version}, buildNumber:${packageInfo.buildNumber}',
        'platform': Utils.getPlatformName(),
      }
    );
    var optRelease = Catcher2Options(reportMode, [
      ConsoleHandler(
          enableApplicationParameters: true,
          enableDeviceParameters: true,
          enableCustomParameters: true,
        )  
    ], 
    customParameters: {
      'timeZoneOffset': now.timeZoneOffset.inHours.toString(),
      'timeZoneName': now.timeZoneName,
      'emailLogin': prefs.getString(Prefs.emailLogin),
      'appName': AppConstants.appTitle,
      'appVersion': '${packageInfo.version}, buildNumber:${packageInfo.buildNumber}',
      'platform': Utils.getPlatformName(),
      'ipInfo': jsonEncode(await getMyIpInfo()),
    });
    Catcher2Options debugOptions = optDebug;
    Catcher2Options releaseOptions = optRelease;
    
    AdaptiveDialog.instance.updateConfiguration(
      macOS: AdaptiveDialogMacOSConfiguration(
        applicationIcon: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: _applicationIconImage,
        ),
      ),
    );

    await setupLocator();
    setHashUrlStrategy();
    
    Catcher2(
      rootWidget: Utils.buildProvider(prefs, MyApp(prefs: prefs)),
      debugConfig: debugOptions,
      releaseConfig: releaseOptions,
      navigatorKey: Catcher2.navigatorKey
    );
  });
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  const MyApp({super.key, required this.prefs});

  static const String tag = 'MyApp';

  @override
  Widget build(BuildContext context) {
    context.read<AccountBloc>().add(CheckAccountEvent());
    return OverlaySupport.global(
      child: _buildMaterial(context),
    );
  }

  Widget _buildMaterial(BuildContext context){
    AppTheme appTheme = context.watch<AppTheme>();

    return MaterialApp(
      navigatorKey: Catcher2.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: AppConstants.appTitle,
      locale: const Locale('en', ''),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: FlexThemeData.light(scheme: FlexScheme.mandyRed),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.mandyRed),
      themeMode: appTheme.mode,
      home: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          AccountModel? account;
          if (state is AccountLoadingState){
            return const Center(child: CircularProgressIndicator());
          } else if (state is AccountOneLoadedState){
            account = state.account;
          } else if (state is AccountErrorState) {
            return NoData(message: state.error.data?.title);
          } 
          if (account==null || account.id==null) {
            return LoginScreen(
              prefs: prefs,
              appTitle: AppConstants.appTitle,
              w: WayScreen(prefs: prefs),
              callback: (){
                Logger.log(tag, message: 'LoginScreen Callback');          
              },  
            );
          } else {
            return WayScreen(prefs: prefs);
          } 
        }
      ),
    );
  }
}
