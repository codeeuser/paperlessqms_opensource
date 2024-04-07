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
import 'package:call/screens/way_screen.dart';
import 'package:call/utils/constants.dart';
import 'package:common/generated/l10n.dart';
import 'package:common/models/account_model.dart';
import 'package:common/models/agent_model.dart';
import 'package:common/models/profile_biz_model.dart';
import 'package:common/models/queue_department_model.dart';
import 'package:common/repositories/agent_repository.dart';
import 'package:common/repositories/biz_repository.dart';
import 'package:common/repositories/department_repository.dart';
import 'package:common/screens/login_screen.dart';
import 'package:common/utils/constants.dart';
import 'package:common/utils/functions.dart';
import 'package:common/utils/no_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectBizScreen extends StatefulWidget {
  final SharedPreferences prefs;
  const SelectBizScreen({super.key, required this.prefs});

  @override
  State<SelectBizScreen> createState() => _SelectBizScreenState();
}

class _SelectBizScreenState extends State<SelectBizScreen> {
  static const String tag = 'SelectBizScreen';

  AgentRepository? _agentRepository;
  BizRepository? _bizRepository;
  DepartmentRepository? _departmentRepository;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    Logger.log(tag, message: '_initialize---');
    _agentRepository = AgentRepository(context: context, prefs: widget.prefs);
    _bizRepository = BizRepository(context: context, prefs: widget.prefs);
    _departmentRepository = DepartmentRepository(context: context, prefs: widget.prefs);
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
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    if (width>ScreenProp.widthPhoneScreenLimit){
      width = ScreenProp.widthPhoneScreenLimit;
    }
    return FutureBuilder(
      future: _agentRepository?.findAgentByLogin(account.login),
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState==ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator());
        }
        List<AgentModel>? list;
        if (snapshot.hasData){
          dynamic data = snapshot.data;
          list = Utils.handleResponseList<AgentModel>(data, null);
          if (list.isEmpty){
            return _buildLogoutButton(message: data.data?.title);
          }
        }
        return Center(
          child: Container(
            alignment: Alignment.topCenter,
            width: width,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(S.of(context).selectOneOfTheItemsBelow),
                  ),
                  if (list==null || list.isEmpty)...[
                    _buildLogoutButton(),
                  ] else ...[
                    for(AgentModel agent in list)...[
                      FutureBuilder(
                        future: _bizRepository?.findProfileBizById(agent.profileBizId),
                        builder: (context, AsyncSnapshot<dynamic> snapshot){
                          ProfileBizModel? biz;
                          bool enable = agent.enable?? false;
                          TextStyle? styleLarge = Theme.of(context).textTheme.bodyLarge;
                          TextStyle? styleMedium = Theme.of(context).textTheme.bodySmall;
                          styleLarge = (enable==true)? styleLarge: styleLarge?.apply(color: Colors.grey);
                          styleMedium = (enable==true)? styleMedium: styleMedium?.apply(color: Colors.grey);
                          if (snapshot.connectionState==ConnectionState.waiting){
                            return const Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasData){
                            dynamic data = snapshot.data;
                            biz = Utils.handleResponseItem<ProfileBizModel>(data, null);
                          } 
                          return ListTile(
                            leading: Icon(CupertinoIcons.creditcard, color: (enable==false)? Colors.grey: null),
                            title: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(biz?.bizName??'', style: styleLarge),
                                  const SizedBox(width: 16),
                                  if (enable==false)...[
                                    Container(
                                      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        border: Border.all(width: 1.0, color: Colors.white),
                                        borderRadius: const BorderRadius.all(Radius.circular(6)),
                                        color: Colors.grey,
                                      ),
                                      child: Text(S.of(context).disabled.toUpperCase(), style: const TextStyle(color: Colors.white)),
                                    )
                                  ]
                                ],
                              ),
                            ),
                            subtitle: FutureBuilder(
                              future: _departmentRepository?.getQueueDepartment(agent.queueDepartment?.id),
                              builder: (context, AsyncSnapshot<dynamic> snapshot) {
                                String depName = '';
                                if (snapshot.hasData){
                                  dynamic data = snapshot.data;
                                  depName = Utils.handleResponseItem<QueueDepartmentModel>(data, null)?.name??'';
                                }
                                return Text('${agent.email??''} | $depName', overflow: TextOverflow.ellipsis, style: styleMedium);
                              }
                            ),
                            onTap: () {
                              if (enable==true){
                                Utils.pushAndRemoveUntilPage(context, WayScreen(prefs: widget.prefs, agent: agent, biz: biz), 'WayScreen');
                              }
                            },
                          );
                        }
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