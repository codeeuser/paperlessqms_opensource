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
import 'package:call/logger.dart';
import 'package:call/screens/select_biz_screen.dart';
import 'package:call/utils/constants.dart';
import 'package:common/app_theme.dart';
import 'package:common/bloc/biz_bloc.dart';
import 'package:common/bloc/department_bloc.dart';
import 'package:common/bloc/terminal_bloc.dart';
import 'package:common/generated/l10n.dart';
import 'package:common/models/account_model.dart';
import 'package:common/models/agent_model.dart';
import 'package:common/models/profile_biz_model.dart';
import 'package:common/models/queue_department_model.dart';
import 'package:common/models/queue_terminal_model.dart';
import 'package:common/screens/login_screen.dart';
import 'package:common/screens/password_change_screen.dart';
import 'package:common/screens/profile_user_screen.dart';
import 'package:common/utils/constants.dart';
import 'package:common/utils/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MorePage extends StatefulWidget {
  final SharedPreferences prefs;
  final AgentModel agent;
  final ProfileBizModel? biz;
  const MorePage({super.key, required this.prefs, required this.agent, this.biz});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  static const String tag = 'MorePage';

  String? _appName;
  String? _packageName;
  String? _version;
  String? _buildNumber;

  AccountModel? _account;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async{  
    int? termianlId = widget.agent.queueTerminal?.id;
    int? departmentId = widget.agent.queueDepartment?.id;
    int? bizId = widget.agent.profileBizId;
    if (termianlId!=null) {
      context.read<TerminalBloc>().add(TerminalLoadOneEvent(id: termianlId));
    }
    if (departmentId!=null) {
      context.read<DepartmentBloc>().add(DepartmentLoadOneEvent(id: departmentId));
    }
    if (bizId!=null){
      context.read<BizBloc>().add(BizByIdEvent(id: bizId));
    }
    
    // PackageInfo
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) async{
      String appName = packageInfo.appName;
      appName = (appName.isEmpty==true)?'PaperlessQMS': appName;
      String packageName = packageInfo.packageName;
      String version = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;

      setState(() {
        _appName = appName;
        _packageName = packageName;
        _version = version;
        _buildNumber = buildNumber;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? styleHeader = Theme.of(context).textTheme.bodyLarge?.apply(color: Colors.white);
    Color colorHeader = Colors.grey.shade400;
    _account = PrefsUtils.getAccount(widget.prefs);

    Size size = MediaQuery.of(context).size;
    double width = size.width;
    if (width>ScreenProp.widthPhoneScreenLimit){
      width = ScreenProp.widthPhoneScreenLimit;
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(S.of(context).more),
      ),
      body: Center(
        child: Container(
          width: width,
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  title: Text(S.of(context).appearance.toUpperCase(), style: styleHeader),
                  tileColor: colorHeader,
                ),
                Consumer<AppTheme>(
                  builder: (context, appTheme, _) {
                    IconData icon = (appTheme.mode==ThemeMode.dark)? CupertinoIcons.moon: CupertinoIcons.sun_max;
                    return ListTile(
                      leading: Icon(icon, semanticLabel: 'Theme Mode'),
                      title: Text(S.of(context).appearance),
                      subtitle: const Text('The place to enable Dark Mode'),
                      trailing: CupertinoSwitch(
                        value: appTheme.mode == ThemeMode.dark,
                        activeColor: Colors.black,
                        onChanged: (bool value) async { 
                          Logger.log(tag, message: 'CupertinoSwitch: $value');             
                          AppTheme appTheme = context.read<AppTheme>();
                          if (value) {
                            appTheme.mode = ThemeMode.dark;
                          } else {
                            appTheme.mode = ThemeMode.light;
                          }
                        },
                      ),
                    );
                  }
                ),
                ListTile(
                  title: Text(S.of(context).agent.toUpperCase(), style: styleHeader),
                  tileColor: colorHeader,
                ),
                ListTile(
                  leading: const Icon(CupertinoIcons.person, semanticLabel: 'Username'),
                  title: Text(S.of(context).username),
                  subtitle: Text('${_account?.login} | ${_account?.email}', overflow: TextOverflow.ellipsis),
                  trailing: IconButton(
                    icon: const Icon(CupertinoIcons.chevron_right),
                    onPressed: (){
                      Utils.pushPage(context, ProfileUserScreen(prefs: widget.prefs), 'ProfileUserScreen');
                    },
                  ),
                ),
                Constants.divider,
                ListTile(
                  leading: const Icon(CupertinoIcons.asterisk_circle, semanticLabel: 'User Password'),
                  title: Text(S.of(context).password),
                  subtitle: const Text('******'),
                  trailing: IconButton(
                    icon: const Icon(CupertinoIcons.chevron_right),
                    onPressed: (){
                      Utils.pushPage(context, PasswordChangeScreen(prefs: widget.prefs), 'PasswordChangeScreen');
                    },
                  ),
                ),
                Constants.divider,
                ListTile(
                  leading: const Icon(CupertinoIcons.star, semanticLabel: 'Terminal'),
                  title: Text(S.of(context).terminal),
                  subtitle: BlocBuilder<TerminalBloc, TerminalState>(
                    builder: (context, state) {
                      QueueTerminalModel? ter;
                      if (state is TerminalOneLoadedState){
                        ter = state.terminal;
                      }
                      return Text('${ter?.name}');
                    }
                  ),
                ),
                Constants.divider,
                ListTile(
                  leading: const Icon(CupertinoIcons.bookmark, semanticLabel: 'Department'),
                  title: Text(S.of(context).department),
                  subtitle: BlocBuilder<DepartmentBloc, DepartmentState>(
                    builder: (context, state) {
                      QueueDepartmentModel? dep;
                      if (state is DepartmentOneLoadedState){
                        dep = state.department;
                      }
                      return Text('${dep?.name}');
                    }
                  ),
                ),
                Constants.divider,
                ListTile(
                  leading: const Icon(CupertinoIcons.creditcard, semanticLabel: 'Company Name'),
                  title: Text(S.of(context).companyName),
                  subtitle: BlocBuilder<BizBloc, BizState>(
                    builder: (context, state) {
                      if (state is BizOneLoadedState){
                        final biz = state.biz;
                        return Text(biz.bizName??'');
                      }
                      return const SizedBox();
                    }
                  ),
                ),
                ListTile(
                  title: Text(S.of(context).moreInformation.toUpperCase(), style: styleHeader),
                  tileColor: colorHeader,
                ),
                ListTile(
                  leading: const Icon(CupertinoIcons.info, semanticLabel: 'App Name'),
                  title: Text(S.of(context).appName),
                  subtitle: Text('$_appName'),
                ),
                Constants.divider,
                ListTile(
                  leading: const Icon(CupertinoIcons.info, semanticLabel: 'Package Name'),
                  title: Text(S.of(context).packageName),
                  subtitle: Text('$_packageName'),
                ),
                Constants.divider,
                ListTile(
                  leading: const Icon(CupertinoIcons.info, semanticLabel: 'Build Number'),
                  title: Text(S.of(context).buildNumber),
                  subtitle: Text('$_buildNumber'),
                ),
                Constants.divider,
                ListTile(
                  leading: const Icon(CupertinoIcons.info, semanticLabel: 'Version'),
                  title: Text(S.of(context).version),
                  subtitle: Text('$_version'),
                ),  
                Constants.divider,
                ListTile(
                  leading: const Icon(CupertinoIcons.refresh_thin, semanticLabel: 'Switch Account'),
                  title: Text(S.of(context).switchAccount),
                  onTap: () async{
                    Utils.pushAndRemoveUntilPage(context, SelectBizScreen(prefs: widget.prefs), 'SelectBizScreen');
                  }
                ),
                Constants.divider,
                ListTile(
                  leading: const Icon(CupertinoIcons.return_icon, semanticLabel: 'Signout'),
                  title: Text(S.of(context).signout),
                  onTap: () async{
                    await PrefsUtils.signout(context, widget.prefs);
                    Utils.pushAndRemoveUntilPage(context, LoginScreen(
                      prefs: widget.prefs,
                      appTitle: AppConstants.appTitle,
                      w: SelectBizScreen(prefs: widget.prefs),
                      callback: (){
                        Logger.log(tag, message: 'LoginScreen Callback');          
                      }), 'LoginScreen'               
                    );
                  },
                ),
                Constants.divider, 
              ],
            ),
          ),
        ),
      ),
    );
  }
}