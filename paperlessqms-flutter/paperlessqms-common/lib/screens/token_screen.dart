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

import 'dart:convert';

import 'package:common/app_absorb.dart';
import 'package:common/bloc/terminal_bloc.dart';
import 'package:common/bloc/token_bloc.dart';
import 'package:common/generated/l10n.dart';
import 'package:common/logger.dart';
import 'package:common/models/account_model.dart';
import 'package:common/models/agent_model.dart';
import 'package:common/models/header_model.dart';
import 'package:common/models/profile_biz_model.dart';
import 'package:common/models/queue_terminal_model.dart';
import 'package:common/models/token_issued_model.dart';
import 'package:common/utils/constants.dart';
import 'package:common/utils/functions.dart';
import 'package:common/utils/no_data.dart';
import 'package:common/utils/web_socket_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stomp_dart_client/stomp.dart';

class TokenScreen extends StatefulWidget {
  final SharedPreferences prefs;
  final AgentModel? agent;
  final bool? fromCallApp;
  final Widget homeScreen;
  const TokenScreen(
      {super.key,
      required this.prefs,
      this.agent,
      this.fromCallApp,
      required this.homeScreen});

  @override
  State<TokenScreen> createState() => _TokenScreenState();
}

class _TokenScreenState extends State<TokenScreen> {
  static const String tag = 'TokenScreen';

  TokenIssuedModel? _tokenIssued;
  StompClient? _stompClient;
  ProfileBizModel? _biz;
  AgentModel? _agent;
  QueueTerminalModel? _queueTerminal;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    Logger.log(tag, message: '_initialize---');
    _agent = widget.agent;
    final terminalId = widget.agent?.queueTerminal?.id;
    if (terminalId!=null) {
      context.read<TerminalBloc>().add(TerminalLoadOneEvent(id: terminalId));
    }

    AccountModel? account = PrefsUtils.getAccount(widget.prefs);
    int? uid = account?.id;
    if (account != null && uid != null && _tokenIssued != null) {
      List<HeaderModel>? headers = PrefsUtils.getHeader(widget.prefs);
      String? tokenId = widget.prefs.getString(Prefs.tokenId);
      String webSocketUrl = '${Constants.urlWebSocket}?access_token=$tokenId';
      _stompClient = WebSocketUtils.connect(webSocketUrl, (frame) {
        _stompClient?.subscribe(
            destination: '${Constants.topicTokenIssuedId}/${_tokenIssued!.id}',
            callback: (frame) async {
              String? jsonText = frame.body;
              if (jsonText != null) {
                dynamic item = jsonDecode(jsonText);
                TokenIssuedModel tokenIssued = TokenIssuedModel.fromMap(item);
                _tokenIssued = tokenIssued;
                setState(() {});
              }
            });
      }, headers);

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
    TextStyle? styleMediumWeight =
        Theme.of(context).textTheme.headlineMedium?.apply(fontWeightDelta: 3);
    TextStyle? styleMedium = Theme.of(context).textTheme.headlineMedium;
    TextStyle? styleSmall = Theme.of(context).textTheme.headlineSmall;
    TextStyle? styleLabelSmall = Theme.of(context).textTheme.labelSmall;
    Size size = MediaQuery.of(context).size;

    String? token;
    String? address;
    return Scaffold(
      body: BlocBuilder<TerminalBloc, TerminalState>(
        builder: (context, state) {
          if (state is TerminalOneLoadedState) {
            _queueTerminal = state.terminal;
          }
          return BlocBuilder<TokenBloc, TokenState>(
            builder: (context, state) {
              if (state is TokenOneLoadedState) {
                _biz = state.biz;
                _tokenIssued = state.token;
                token =
                    '${_tokenIssued?.tokenLetter ?? ''}-${_tokenIssued?.tokenNumber ?? ''}';
                address = Utils.aesEncrypt(
                    '${Constants.qrPrefixTokenIssuded}${_tokenIssued?.id}',
                    Constants.password);
              } else if (state is TokenInvalidHourState) {
                Utils.overlayInfoMessage(msg: S.of(context).closed);
                return NoData(
                    message: S.of(context).closed, child: _buildHomeBtn());
              } else if (state is TokenInvalidMaxState) {
                Utils.overlayInfoMessage(
                    msg: '${S.of(context).reachedMaxToken} [${state.count}]]');
                return NoData(
                    message:
                        '${S.of(context).reachedMaxToken} [${state.count}]]',
                    child: _buildHomeBtn());
              } else if (state is TokenFailureState) {
                Utils.overlayWarnMessage(warns: [S.of(context).fail]);
                return NoData(
                    message: S.of(context).fail, child: _buildHomeBtn());
              }
              return Container(
                alignment: Alignment.topCenter,
                width: size.width,
                height: size.height,
                color: Utils.getStatusColor(_tokenIssued?.statusName),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 60),
                      ChoiceChip(
                          label: Text(_tokenIssued?.statusName ?? '',
                              style: styleMediumWeight),
                          selected: true),
                      const SizedBox(height: 8),
                      if (_tokenIssued?.statusName == Status.onqueue) ...[
                        Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 40),
                            decoration: DecoratorUtils.box(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(S.of(context).proceedTo,
                                    style: styleMedium),
                                const SizedBox(height: 8),
                                Text('${_tokenIssued?.terminalName}',
                                    style: styleMedium),
                              ],
                            )),
                      ],
                      const SizedBox(height: 8),
                      Text(_biz?.bizName ?? '', style: styleMediumWeight),
                      const SizedBox(height: 16),
                      Text(_tokenIssued?.departmentName ?? '',
                          style: styleSmall),
                      const SizedBox(height: 16),
                      Text(_tokenIssued?.serviceName ?? '', style: styleSmall),
                      const SizedBox(height: 16),
                      if (address != null) ...[
                        QrImageView(
                          data: address!,
                          gapless: false,
                          size: 200,
                          backgroundColor: Colors.white,
                          version: QrVersions.auto,
                        ),
                      ],
                      const SizedBox(height: 4),
                      Text(address ?? '', style: styleLabelSmall),
                      const SizedBox(height: 16),
                      Text(token ?? '', style: style),
                      const SizedBox(height: 24),
                      _buildHomeBtn(),
                      if (widget.fromCallApp == null &&
                          _tokenIssued?.statusName == Status.onwait) ...[
                        const SizedBox(height: 24),
                        ElevatedButton(
                          child: Text(
                              '${S.of(context).updateTo} ${Status.cancel}'),
                          onPressed: () async {
                            TokenIssuedModel? tokenIssued = _tokenIssued;
                            if (tokenIssued == null) return;
                            AppAbsorb appAbsorb = context.read<AppAbsorb>();
                            final agent = _agent;
                            if (agent == null) return;
                            Utils.statusCancel(tokenIssued);
                            await Utils.updateTokenIssued(
                              context,
                              appAbsorb,
                              agent,
                              tokenIssued,
                            );
                            await Utils.pushAndRemoveUntilPage(
                                context, widget.homeScreen, 'HOME');
                          },
                        ),
                      ],
                      if (widget.fromCallApp == true &&
                          (_tokenIssued?.statusName == Status.onwait ||
                              _tokenIssued?.statusName == Status.recall)) ...[
                        if (_tokenIssued?.departmentId ==
                            _agent?.queueDepartment?.id) ...[
                          const SizedBox(height: 24),
                          ElevatedButton(
                            child: Text(
                                '${S.of(context).updateTo} ${Status.onqueue}'),
                            onPressed: () async {
                              TokenIssuedModel? tokenIssued = _tokenIssued;
                              if (tokenIssued == null) return;
                              AppAbsorb appAbsorb = context.read<AppAbsorb>();
                              final agent = _agent;
                              if (agent == null) return;
                              Utils.statusQueue(tokenIssued, _queueTerminal);
                              await Utils.updateTokenIssued(
                                context,
                                appAbsorb,
                                agent,
                                tokenIssued,
                              );
                              await Utils.pushAndRemoveUntilPage(
                                  context, widget.homeScreen, 'HOME');
                            },
                          )
                        ],
                      ],
                      if (widget.fromCallApp == true &&
                          _tokenIssued?.statusName == Status.onqueue) ...[
                        if (_tokenIssued?.terminalId ==
                            _agent?.queueTerminal?.id) ...[
                          const SizedBox(height: 24),
                          ElevatedButton(
                            child: Text(
                                '${S.of(context).updateTo} ${Status.completed}'),
                            onPressed: () async {
                              TokenIssuedModel? tokenIssued = _tokenIssued;
                              if (tokenIssued == null) return;
                              AppAbsorb appAbsorb = context.read<AppAbsorb>();
                              final agent = _agent;
                              if (agent == null) return;
                              Utils.statusCompleted(tokenIssued, agent);
                              await Utils.updateTokenIssued(
                                context,
                                appAbsorb,
                                agent,
                                tokenIssued,
                              );
                              await Utils.pushAndRemoveUntilPage(
                                  context, widget.homeScreen, 'HOME');
                            },
                          ),
                        ],
                      ]
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildHomeBtn() {
    return ElevatedButton(
      child: Text(S.of(context).home),
      onPressed: () async {
        await Utils.pushAndRemoveUntilPage(context, widget.homeScreen, 'HOME');
      },
    );
  }
}
