// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:common/bloc/token_bloc.dart';
import 'package:common/generated/l10n.dart';
import 'package:common/models/header_model.dart';
import 'package:common/models/profile_biz_model.dart';
import 'package:common/models/queue_department_model.dart';
import 'package:common/models/token_issued_model.dart';
import 'package:common/screens/login_screen.dart';
import 'package:common/utils/constants.dart';
import 'package:common/utils/functions.dart';
import 'package:common/utils/no_data.dart';
import 'package:common/utils/web_socket_utils.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiosk/logger.dart';
import 'package:kiosk/screens/way_screen.dart';
import 'package:kiosk/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stomp_dart_client/stomp.dart';

class RunningTokenPage extends StatefulWidget {
  final SharedPreferences prefs;
  final QueueDepartmentModel department;
  final ProfileBizModel biz;
  const RunningTokenPage({super.key, required this.prefs, required this.department, required this.biz});

  @override
  State<RunningTokenPage> createState() => _RunningTokenPageState();
}

class _RunningTokenPageState extends State<RunningTokenPage> {
  static const String tag = 'RunningTokenPage';

  List<TokenIssuedModel>? _issuedList;
  StompClient? _stompClient;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    Logger.log(tag, message: '_initialize---');
    List<int> statues = [
      StatusCode.onwait, 
      StatusCode.onqueue, 
      StatusCode.recall, 
      StatusCode.transfer, 
      StatusCode.completed,
      StatusCode.cancel,
      StatusCode.timeout];
    context.read<TokenBloc>().add(
      TokenByDepartmentWithStatusEvent(
        department: widget.department,
        statues: statues,
        reset: false,
        page: 0,
        pageSize: 50,
        sortBy: 'modifiedDate,desc',
      )
    );

    List<HeaderModel>? headers = PrefsUtils.getHeader(widget.prefs);
    String? tokenId = widget.prefs.getString(Prefs.tokenId);
    String webSocketUrl = '${Constants.urlWebSocket}?access_token=$tokenId';
    _stompClient = WebSocketUtils.connect(webSocketUrl, (frame) {
      _stompClient?.subscribe(destination: '${Constants.topicRunningToken}/${widget.department.id}', callback: (frame) async{
        String? jsonText = frame.body;
        if (jsonText!=null){
          List<TokenIssuedModel> issuedList = [];
          List<dynamic> list = jsonDecode(jsonText);
          for (dynamic item in list) {
            TokenIssuedModel tokenIssued = TokenIssuedModel.fromMap(item); 
            issuedList.add(tokenIssued);
          } 
          issuedList.sortDescByNullable<num>((e) => e.modifiedDate);
          _issuedList = List.from(issuedList); 
          setState(() {
            
          });
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
    TextStyle? style = Theme.of(context).textTheme.headlineLarge;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        actions: [
          ElevatedButton(
            child: Text(S.of(context).signout),
            onPressed: () async{
              await PrefsUtils.signout(context, widget.prefs);
              Utils.pushAndRemoveUntilPage(context, LoginScreen(
                prefs: widget.prefs,
                appTitle: AppConstants.appTitle,
                w: WayScreen(prefs: widget.prefs),
                callback: (){
                  Logger.log(tag, message: 'LoginScreen Callback');          
                }), 'LoginScreen'               
              );
            },
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: BlocBuilder<TokenBloc, TokenState>(
            builder: (context, state) {
              if (state is TokenLoadedCallState){
                _issuedList = state.tokens;
              }
              if (_issuedList?.isEmpty==true){
                return const NoData();
              }
              _issuedList?.sortDescByNullable<num>((e) => e.modifiedDate);
              final firstToken = _issuedList?.first;
              _issuedList?.sortAscByNullable<num>((e) => e.statusCode);
              return Column(
                children: [
                  Text(widget.biz.bizName??'', style: style),
                  const SizedBox(height: 8),
                  Text(widget.department.name??'', style: style),
                  const SizedBox(height: 16),
                  _buildDesc(),
                   const SizedBox(height: 16),
                  if (firstToken!=null)...[
                    DottedBorder(
                      color: Colors.orangeAccent,
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(12),
                      dashPattern: const [6, 4, 6, 4], 
                      padding: const EdgeInsets.all(4),
                      strokeWidth: 2,
                      child: _buildBox(firstToken)
                    ),
                    const SizedBox(height: 8),
                  ],
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for(TokenIssuedModel issued in _issuedList??[])...[
                        _buildBox(issued),
                      ]
                    ]
                  ),
                ],
              );
            }
          )
        )
      )
    );
  }

  Widget _buildDesc(){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Utils.buildStatusBox(Status.onwait),
          const SizedBox(width: 24),
          Utils.buildStatusBox(Status.onqueue),
          const SizedBox(width: 24),
          Utils.buildStatusBox(Status.completed),
          const SizedBox(width: 24),
          Utils.buildStatusBox(Status.recall),
          const SizedBox(width: 24),
          Utils.buildStatusBox(Status.timeout),
          const SizedBox(width: 24),
          Utils.buildStatusBox(Status.transfer),
          const SizedBox(width: 24),
          Utils.buildStatusBox(Status.cancel),
        ],
      ),
    );
  }

  Widget _buildBox(TokenIssuedModel issued){
    TextStyle? style = Theme.of(context).textTheme.headlineMedium?.apply(color: Colors.white);
    TextStyle? styleMedium = Theme.of(context).textTheme.labelLarge?.apply(color: Colors.white);
    TextStyle? styleSmall = Theme.of(context).textTheme.labelSmall?.apply(color: Colors.white);
    String sToken = '${issued.tokenLetter??''}-${issued.tokenNumber??''}';
    Color color = Utils.getStatusColor(issued.statusName);
    String statusName = Utils.getStatusName(issued.statusCode);
    String ago = Utils.printAgo(issued.createdDate, 'en');
    String? terminal = issued.terminalName;
    return Container(
      width: 220,
      height: 160,
      padding: const EdgeInsets.all(8),
      decoration: DecoratorUtils.box(color: color),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(child: Text(sToken, style: style)),
          const SizedBox(height: 8),
          Text(statusName, style: styleMedium),
          const SizedBox(height: 8),
          if (terminal!=null)...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: DecoratorUtils.box(color: Utils.getStatusColor(statusName).darken(), borderColor: Colors.white),
              child: Text(terminal, style: styleMedium)
            ),
            const SizedBox(height: 8),
          ],
          Text(ago, style: styleSmall),
        ],
      ),
    );
  }
}