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
import 'package:client/logger.dart';
import 'package:client/screens/home_screen.dart';
import 'package:client/screens/more_screen.dart';
import 'package:client/screens/token_completed_screen.dart';
import 'package:client/utils/constants.dart';
import 'package:common/app_absorb.dart';
import 'package:common/screens/login_screen.dart';
import 'package:common/utils/constants.dart';
import 'package:common/utils/functions.dart';
import 'package:common/utils/no_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:common/generated/l10n.dart';

class WayScreen extends StatefulWidget {
  final SharedPreferences prefs;
  const WayScreen({super.key, required this.prefs});

  @override
  State<WayScreen> createState() => _WayScreenState();
}

class _WayScreenState extends State<WayScreen> {
  static const String tag = 'WayScreen';

  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    Logger.log(tag, message: '_initialize---');
    Logger.sendCatcherError(tag, 'Test Exception', '');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {    
    final account = PrefsUtils.getAccount(widget.prefs);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            _pageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: _pageIndex,
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: const Icon(CupertinoIcons.home),
            icon: const Icon(Icons.home_outlined),
            label: S.of(context).home,
          ),
          NavigationDestination(
            icon: const Icon(CupertinoIcons.square_on_square),
            label: S.of(context).completed,
          ),
          NavigationDestination(
            icon: const Icon(CupertinoIcons.ellipsis_circle),
            label: S.of(context).more,
          ),
        ],
      ),
      body: Consumer<AppAbsorb>(
        builder: (context, appAbsorb, _) {
          if (appAbsorb.recaptcha==false){
            return _buildLogoutButton();
          }
          return SafeArea(
            top: false,
            child: (account?.authorities?.contains('ROLE_USER')==false)?
              _buildLogoutButton()
            : [
              HomeScreen(prefs: widget.prefs),
              TokenCompletedScreen(prefs: widget.prefs),
              MoreScreen(prefs: widget.prefs)
            ][_pageIndex],
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