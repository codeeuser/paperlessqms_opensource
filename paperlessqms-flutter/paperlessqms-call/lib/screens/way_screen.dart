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

import 'package:call/logger.dart';
import 'package:call/screens/more_page.dart';
import 'package:call/screens/select_biz_screen.dart';
import 'package:call/screens/token_call_page.dart';
import 'package:call/screens/token_completed_page.dart';
import 'package:call/screens/token_list_page.dart';
import 'package:call/utils/constants.dart';
import 'package:common/app_absorb.dart';
import 'package:common/bloc/department_bloc.dart';
import 'package:common/bloc/terminal_bloc.dart';
import 'package:common/bloc/token_bloc.dart';
import 'package:common/config.dart';
import 'package:common/generated/l10n.dart';
import 'package:common/models/agent_model.dart';
import 'package:common/models/header_model.dart';
import 'package:common/models/profile_biz_model.dart';
import 'package:common/screens/login_screen.dart';
import 'package:common/screens/scanner_screen.dart';
import 'package:common/screens/token_screen.dart';
import 'package:common/utils/constants.dart';
import 'package:common/utils/functions.dart';
import 'package:common/utils/no_data.dart';
import 'package:common/utils/web_socket_utils.dart';
import 'package:common/widgets/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stomp_dart_client/stomp.dart';

class WayScreen extends StatefulWidget {
  final SharedPreferences prefs;
  final AgentModel agent;
  final ProfileBizModel? biz;
  const WayScreen({super.key, required this.prefs, required this.agent, this.biz});

  @override
  State<WayScreen> createState() => _WayScreenState();
}

class _WayScreenState extends State<WayScreen> {
  static const String tag = 'WayScreen';
  final _scaffoldKey =  GlobalKey<ScaffoldState>();

  int _countCall = 0;
  int _countList = 0;

  StompClient? _stompClient;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    Logger.log(tag, message: '_initialize---');
    Logger.sendCatcherError(tag, 'Test Exception', '');
    final department = widget.agent.queueDepartment;
    final terminal = widget.agent.queueTerminal;
    final departmentId = department?.id;
    final terminalId = terminal?.id;
    if (department!=null && terminal!=null){
      context.read<TokenBloc>().add(
        TokenCountHomeEvent(
          statuesCall: statues4Call, 
          statuesList: statues4List, 
          department: department, 
          terminal: terminal,
          reset: false
        ));
    }
    if (departmentId!=null){
      context.read<DepartmentBloc>().add(DepartmentLoadOneEvent(id: departmentId));
    }
    if (terminalId!=null){
      context.read<TerminalBloc>().add(TerminalLoadOneEvent(id: terminalId));
    }

    List<HeaderModel>? headers = PrefsUtils.getHeader(widget.prefs);
    String? tokenId = widget.prefs.getString(Prefs.tokenId);
      String webSocketUrl = '${Constants.urlWebSocket}?access_token=$tokenId';
      _stompClient = WebSocketUtils.connect(webSocketUrl, (frame) {
        _stompClient?.subscribe(destination: '${Constants.topicCountCall}/${widget.agent.queueDepartment?.id}', callback: (frame) async{
          String? jsonText = frame.body;
          if (jsonText!=null){
            dynamic data = jsonDecode(jsonText);
            if (data is int){
              _countCall = data;
              setState(() {
                
              });
            }
          }
        });
        _stompClient?.subscribe(destination: '${Constants.topicCountList}/${widget.agent.queueDepartment?.id}/${widget.agent.queueTerminal?.id}', callback: (frame) async{
          String? jsonText = frame.body;
          if (jsonText!=null){
            dynamic data = jsonDecode(jsonText);
            if (data is int){
              _countList = data;
              Logger.log(tag, message: '_countList: $_countList');
              setState(() {
                
              });
            }
          }
        });
      }, headers);
      if (_stompClient?.isActive==false) {
        _stompClient?.activate();
      }
  }

  @override
  void dispose() {
    _stompClient?.deactivate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        top: false,
        child: Consumer<AppAbsorb>(
          builder: (context, appAbsorb, _) {
            if (appAbsorb.recaptcha==false){
              return _buildLogoutButton();
            }
            return BlocBuilder<TokenBloc, TokenState>(
              builder: (context, state) {
                if (state is TokenCountHomeState){
                  _countCall = state.countCall;
                  _countList = state.countList;
                }
                return _buildPhoneContent(_countCall, _countList);
              }
            );
          }
        ),
      ),
    );
  }

  Widget _buildPhoneContent(int countMyOnWait, int countMyNonOnWait){
    TextStyle? styleMedium = Theme.of(context).textTheme.titleMedium;
    TextStyle? styleSmall = Theme.of(context).textTheme.labelSmall;
    double shortestSide = MediaQuery.of(context).size.shortestSide;
    double sizeButton = (shortestSide > 300)? shortestSide * 0.25: shortestSide * 0.15;
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    if (width>ScreenProp.widthPhoneScreenLimit){
      width = ScreenProp.widthPhoneScreenLimit;
    }
    return Center(
      child: Container(
        alignment: Alignment.topCenter,
        width: width,
        child: Column(
          children: <Widget>[
            const Header(
              backgroundColor: Colors.redAccent,
              fontColor: Colors.white,
            ),
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(AppConstants.appTitle.toUpperCase(), style: styleMedium),
                          const SizedBox(height: 4),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BlocBuilder<DepartmentBloc, DepartmentState>(
                                  builder: (context, state) {
                                    String depName = '';
                                    if (state is DepartmentOneLoadedState){
                                      depName = state.department.name??'';
                                    }
                                    return Text(depName, overflow: TextOverflow.ellipsis, style: styleSmall);
                                  }
                                ),
                                const Text('  |  '),
                                BlocBuilder<TerminalBloc, TerminalState>(
                                  builder: (context, state) {
                                    String terName = '';
                                    if (state is TerminalOneLoadedState){
                                      terName = state.terminal.name??'';
                                    }
                                    return Text(terName, overflow: TextOverflow.ellipsis, style: styleSmall);
                                  }
                                ),
                              ],
                            ),
                          ),
                          
                          const SizedBox(height: 4),
                          Text('${widget.agent.email}', style: styleSmall),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: shortestSide * 0.9,
                      height: shortestSide,
                      child: SizedBox(
                        child: GridView.count(
                          crossAxisCount: 2,
                          physics: const NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            _buildButton(Icon(CupertinoIcons.list_bullet, size: sizeButton, color: Colors.redAccent, semanticLabel: 'List'), S.of(context).markComplete.toUpperCase(), countMyNonOnWait, () async{
                              Utils.pushPage(context, TokenListPage(prefs: widget.prefs, agent: widget.agent), 'TokenListPage');
                            }),
                            _buildButton(Icon(CupertinoIcons.square_on_square, size: sizeButton, color: Colors.redAccent, semanticLabel: 'Completed Token'), S.of(context).completed.toUpperCase(), null, () async{
                              Utils.pushPage(context,  TokenCompletedPage(prefs: widget.prefs, agent: widget.agent), 'TokenCompletedPage');
                            }),
                            _buildButton(Icon(CupertinoIcons.forward, size: sizeButton, color: Colors.redAccent, semanticLabel: 'Call Token'), S.of(context).callToken.toUpperCase(), countMyOnWait , () async{
                              Utils.pushPage(context,  TokenCallPage(prefs: widget.prefs, agent: widget.agent), 'TokenCallPage');
                            }),
                            _buildButton(Icon(CupertinoIcons.qrcode_viewfinder, size: sizeButton, color: Colors.redAccent, semanticLabel: 'Scanner'), S.of(context).scanner.toUpperCase(), null, () async{
                              Utils.pushPage(context, 
                                ScannerScreen(
                                  prefs: widget.prefs, 
                                  back: WayScreen(prefs: widget.prefs, agent: widget.agent),
                                  actionCallback: _actionCallback,
                                  live: Utils.isMobileNotBrowser,
                                ), 
                              'ScannerScreen');
                            }),
                          ],
                        )
                      ),
                    ),
                  ),
                  
                  IconButton(
                    icon: const Icon(CupertinoIcons.ellipsis_circle_fill),
                    onPressed: (){
                      Utils.pushPage(context,  MorePage(prefs: widget.prefs, agent: widget.agent, biz: widget.biz), 'MorePage');
                    },
                  ),
            
                  TextButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Icon(CupertinoIcons.link, semanticLabel: 'Link'),
                        const SizedBox(width: 10),
                        Text('Powered by Wheref.com', style: Theme.of(context).textTheme.titleMedium),
                      ],
                    ),
                    onPressed: () async{
                      Utils.launchThisUrl('$protocol://$domainWheref');
                    },
                  ),
                ],
              ),
            )
          ],
        ), 
      ),
    );
  }

  Widget _buildButton(Icon icon, String label, int? count, VoidCallback onPressed){
    return SizedBox(
      child: Center(
        child: TextButton(
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  icon,
                  Text(label)
                ],
              ),
              (count!=null)?
               Positioned(  // draw a red marble
                top: 10.0,
                right: 0.0,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    )
                  ),
                  child: Text(' $count ', style: Theme.of(context).textTheme.labelMedium?.apply(color: Colors.black, fontWeightDelta: 10)),
                )
              ): const SizedBox(height: 0)
            ],
          ),
          onPressed: (){
            onPressed();
          },
        ),
      )
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

  void _actionCallback(String text, QRCodeDartScanController? controller) async{
    Logger.log(tag, message: 'text: $text');
    if (text.length<Constants.qrPrefixTokenIssuded.length){  
      Utils.overlayInfoMessage(msg: S.of(context).invalid);    
      return;
    }
    String str = Utils.retriveQrCodeId(text, Constants.qrPrefixTokenIssuded);
    int? tokenId = int.tryParse(str);
    if (tokenId==null) {
      Utils.overlayInfoMessage(msg: S.of(context).invalid);
      return;
    }
    context.read<TokenBloc>().add(TokenWithQrEvent(
        tokenId: tokenId,
        departmentId: widget.agent.queueDepartment?.id,
        controller: controller));
    Navigator.of(context).pop();
    Utils.pushAndRemoveUntilPage(
      context, 
      TokenScreen(
        prefs: widget.prefs, 
        fromCallApp: true,
        agent: widget.agent,
        homeScreen: WayScreen(prefs: widget.prefs, agent: widget.agent)
    ), 'TokenScreen');
  }
}