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
// ignore_for_file: use_build_context_synchronously

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:call/logger.dart';
import 'package:call/screens/select_agent.dart';
import 'package:call/screens/user_info_screen.dart';
import 'package:call/screens/way_screen.dart';
import 'package:common/app_absorb.dart';
import 'package:common/bloc/token_bloc.dart';
import 'package:common/generated/l10n.dart';
import 'package:common/models/agent_model.dart';
import 'package:common/models/token_issued_model.dart';
import 'package:common/utils/constants.dart';
import 'package:common/utils/functions.dart';
import 'package:common/utils/no_data.dart';
import 'package:common/widgets/error_box_widget.dart';
import 'package:common/widgets/msg_box_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenListPage extends StatefulWidget {
  final SharedPreferences prefs;
  final AgentModel agent;
  const TokenListPage({super.key, required this.prefs, required this.agent});

  @override
  State<TokenListPage> createState() => _TokenListPageState();
}

class _TokenListPageState extends State<TokenListPage> {
  static const String tag = 'TokenListPage';
  
  final ValueNotifier<List<String>> _errors = ValueNotifier([]);
  final ValueNotifier<List<String>> _messages = ValueNotifier([]);

  List<TokenIssuedModel>? _issuedList;
  bool? _loading;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    Logger.log(tag, message: '_initialize---');
    _loading = true;
    await _findIssuedList();
  }

  @override
  void dispose() {
    _errors.dispose();
    _messages.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(S.of(context).markComplete),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.chevron_back),
          onPressed: (){
            Utils.pushAndRemoveUntilPage(context, WayScreen(prefs: widget.prefs, agent: widget.agent), 'WayScreen');
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.refresh),
            onPressed: () async{
              _messages.value = [];
              _errors.value = [];
              await _findIssuedList();
            },
          ),
        ],
      ),
      body: Consumer<AppAbsorb>(
        builder: (context, appAbsorb, child){
          Size size = MediaQuery.of(context).size;
          double width = size.width;
          if (width>ScreenProp.widthPhoneScreenLimit){
            width = ScreenProp.widthPhoneScreenLimit;
          }
          return AbsorbPointer(
            absorbing: appAbsorb.absorbing,
            child: BlocBuilder<TokenBloc, TokenState>(
              builder: (context, state){
                if (state is TokenLoadingState){
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TokenLoadedListState){
                  _issuedList = state.tokens;
                } else if (state is TokenTransferedState){
                  _messages.value = [S.of(context).success];
                } else if (state is TokenSameState){
                  _messages.value = [state.sToken, S.of(context).tokenWasUpdatedByOthers];
                } else if (state is TokenSuccessState){
                  _messages.value = [S.of(context).success];
                }
                _issuedList?.sortAscByNullable<num>((e) => e.modifiedDate);
                _issuedList?.sortDescByNullable<num>((e) => e.statusCode);
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Utils.buildStatusBox(Status.onqueue),
                              const SizedBox(width: 24),
                              Utils.buildStatusBox(Status.recall),
                              const SizedBox(width: 24),
                              Utils.buildStatusBox(Status.transfer),
                            ],
                          ),
                          ErrorBoxWidget(errors: _errors, width: width),
                          MsgBoxWidget(messages: _messages, width: width),
                          if (_loading==true)...[
                            const Center(child: CircularProgressIndicator()),
                          ] else if (_issuedList?.isEmpty==true)...[
                            const NoData(),
                          ] else ...[
                            Constants.divider,
                            for(TokenIssuedModel issued in _issuedList??[])...[
                              _buildItem(issued, appAbsorb),
                              Constants.divider,
                            ],
                          ],                        
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      )
    );
  }

  Widget _buildItem(TokenIssuedModel issued, AppAbsorb appAbsorb){
    bool isContain = statues4List.contains(issued.statusCode) && issued.terminalId==widget.agent.queueTerminal?.id;
    return ListTile(
      tileColor: (isContain==false)?Colors.yellowAccent: null,
      leading: Utils.getStatusLeading(issued),
      title: Text('${issued.tokenLetter}-${issued.tokenNumber}'), 
      trailing: (isContain==true)? IconButton(
        icon: const Icon(CupertinoIcons.ellipsis_vertical_circle),
        onPressed: () async{
          await _showAction(issued);
        },
      ): null,
      subtitle: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [                        
            ChoiceChip(
              label: Text(issued.serviceName??''),
              avatar: const Icon(CupertinoIcons.cursor_rays),
              selected: false,
            ),
            const SizedBox(width: 8),
            Text(issued.statusName??''),
            const SizedBox(width: 8),
            Text(Utils.printAgo(issued.createdDate, 'en')),
          ],
        ),
      ),
      onTap: () async{
        if (isContain==false) {
          Utils.overlayInfoMessage(msg: S.of(context).noAction);
          return; 
        }
        Utils.statusCompleted(issued, widget.agent);
        await Utils.updateTokenIssued(
          context, 
          appAbsorb,
          widget.agent,
          issued,
        );
      },
    );
  }

  Future<void> _findIssuedList() async{
    final agentId = widget.agent.id;
    if (agentId!=null) {
      _loading = false;
      context.read<TokenBloc>().add(TokenByAgentWithStatusEvent(agentId: agentId, statues: statues4List, reset: false));
    }
  }
 
  Future<void> _showAction(TokenIssuedModel issued) async{
    AppAbsorb appAbsorb = context.read<AppAbsorb>();
    String userInfo = 'userInfo';
    String? result = await showModalActionSheet<String>(
      context: context,
      title: S.of(context).tokenManagement,
      actions: [
        SheetAction(
          label: S.of(context).completeToken,
          icon: CupertinoIcons.add,
          key: Status.completed,
        ),
        SheetAction(
          label: S.of(context).timeoutToken,
          icon: CupertinoIcons.add,
          key: Status.timeout,
        ),
        SheetAction(
          label: S.of(context).recallToken,
          icon: CupertinoIcons.add,
          key: Status.recall,
        ),
        SheetAction(
          label: S.of(context).transferToken,
          icon: CupertinoIcons.add,
          key: Status.transfer,
        ),
        SheetAction(
          label: S.of(context).userProfile,
          icon: CupertinoIcons.person,
          key: userInfo,
        ),
      ],
    );
    Logger.log(tag, message: 'result: $result');

    if (result==userInfo){
      Utils.pushPage(context, UserInfoScreen(prefs: widget.prefs, issued: issued), 'UserInfoScreen');
      return;
    }

    if (result==Status.completed){
      Utils.statusCompleted(issued, widget.agent);
      await Utils.updateTokenIssued(
        context, 
        appAbsorb,
        widget.agent,
        issued,
      );
    } else if (result==Status.timeout){
      Utils.statusTimeout(issued);
      await Utils.updateTokenIssued(
        context, 
        appAbsorb,
        widget.agent,
        issued,
      );
    } else if (result==Status.recall){
      Utils.statusRecall(issued);
      await Utils.updateTokenIssued(
        context, 
        appAbsorb,
        widget.agent,
        issued,
      );
    } else if (result==Status.transfer){
      Utils.pushPage(context, SelectAgent(prefs: widget.prefs, issued: issued, agent: widget.agent), 'SelectAgent');
    }
  }
}