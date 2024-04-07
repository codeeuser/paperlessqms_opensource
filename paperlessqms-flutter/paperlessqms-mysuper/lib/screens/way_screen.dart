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
import 'package:common/models/profile_biz_model.dart';
import 'package:mysuper/logger.dart';
import 'package:mysuper/screens/biz_page.dart';
import 'package:mysuper/screens/more_page.dart';
import 'package:mysuper/screens/select_biz_screen.dart';
import 'package:mysuper/utils/constants.dart';
import 'package:common/generated/l10n.dart';
import 'package:common/screens/login_screen.dart';
import 'package:common/utils/constants.dart';
import 'package:common/utils/functions.dart';
import 'package:common/utils/no_data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WayScreen extends StatefulWidget {
  final SharedPreferences prefs;
  final ProfileBizModel biz;
  const WayScreen({super.key, required this.prefs, required this.biz});

  @override
  State<WayScreen> createState() => _WayScreenState();
}

class _WayScreenState extends State<WayScreen> {
  static const String tag = 'WayScreen';

  final ValueNotifier<int> _pageIndex = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    Logger.log(tag, message: '_initialize---');
  }

  @override
  void dispose() {
    _pageIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final account = PrefsUtils.getAccount(widget.prefs);
    return Scaffold(
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: _pageIndex,
        builder: (context, int pageIndex, _){
          if (Utils.isPhoneSize(context)==true){
            return NavigationBar(
              onDestinationSelected: (int index) {
                _pageIndex.value = index;
              },
              indicatorColor: Colors.amber,
              selectedIndex: pageIndex,
              destinations: <Widget>[
                NavigationDestination(
                  icon: const Icon(Icons.home_outlined),
                  selectedIcon: const Icon(Icons.home),
                  label: S.of(context).business,
                ),
                NavigationDestination(
                  icon: const Icon(Icons.star_border),
                  selectedIcon: const Icon(Icons.star),
                  label: S.of(context).store,
                ),
              ],
            );
          }
          return const SizedBox();
        }
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: _pageIndex,
          builder: (context, int pageIndex, _) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (Utils.isPhoneSize(context)==false) ...[
                  NavigationRail(
                    selectedIndex: pageIndex,
                    groupAlignment: -0.5,
                    onDestinationSelected: (int index) {
                      _pageIndex.value = index;
                    },
                    labelType: NavigationRailLabelType.all,
                    destinations: <NavigationRailDestination>[
                      NavigationRailDestination(
                        icon: const Icon(Icons.home_outlined),
                        selectedIcon: const Icon(Icons.home),
                        label: Text(S.of(context).business),
                      ),
                      NavigationRailDestination(
                        icon: const Icon(Icons.more_horiz_outlined),
                        selectedIcon: const Icon(Icons.more_horiz),
                        label: Text(S.of(context).more),
                      ),
                    ],
                  ),
                  const VerticalDivider(thickness: 1, width: 1),
                ],
                if (account?.authorities?.contains('ROLE_SUPER')==false)...[
                  Expanded(
                    child: _buildLogoutButton(message: S.of(context).notAdminRole),
                  ),
                ] else ...[
                  Expanded(
                    child: [
                      BizPage(prefs: widget.prefs, biz: widget.biz),
                      MorePage(prefs: widget.prefs),
                    ][pageIndex],
                  ),
                ],
              ],
            );
          }
        ),
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