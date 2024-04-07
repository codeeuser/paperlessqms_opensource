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

import 'package:client/initial_app.dart';
import 'package:client/logger.dart';
import 'package:client/screens/biz_screen.dart';
import 'package:client/screens/department_screen.dart';
import 'package:client/screens/way_screen.dart';
import 'package:client/utils/constants.dart';
import 'package:collection/collection.dart';
import 'package:common/bloc/biz_bloc.dart';
import 'package:common/bloc/department_bloc.dart';
import 'package:common/bloc/token_bloc.dart';
import 'package:common/generated/l10n.dart';
import 'package:common/models/account_model.dart';
import 'package:common/models/header_model.dart';
import 'package:common/models/profile_biz_model.dart';
import 'package:common/models/token_issued_model.dart';
import 'package:common/screens/scanner_screen.dart';
import 'package:common/screens/token_screen.dart';
import 'package:common/utils/constants.dart';
import 'package:common/utils/functions.dart';
import 'package:common/utils/no_data.dart';
import 'package:common/utils/web_socket_utils.dart';
import 'package:common/widgets/header.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stomp_dart_client/stomp.dart';

class HomeScreen extends StatefulWidget {
  final SharedPreferences prefs;
  const HomeScreen({super.key, required this.prefs});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const String tag = 'HomeScreen';

  final TextEditingController _searchBizController = TextEditingController();

  List<ProfileBizModel>? _bizs;
  List<TokenIssuedModel>? _tokenIssuedList;
  StompClient? _stompClient;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    if (Utils.isMobileNotBrowser) {
      bool? allowed =
          await AppUtils.requestPermissions(flutterLocalNotificationsPlugin);
      Logger.log(tag, message: '_initialize---, allowed: $allowed');
    }
    context.read<BizBloc>().add(BizLoadAllEvent(
        page: 0,
        pageSize: 10,
        sortBy: 'bizLevel,modifiedDate,desc',
        enable: true));

    AccountModel? account = PrefsUtils.getAccount(widget.prefs);
    int? uid = account?.id;
    if (account != null && uid != null) {
      final statues = [
        StatusCode.onwait,
        StatusCode.onqueue,
        StatusCode.recall
      ];
      context.read<TokenBloc>().add(
          TokenByUidWithStatusEvent(uid: uid, statues: statues, reset: false));

      List<HeaderModel>? headers = PrefsUtils.getHeader(widget.prefs);
      String? tokenId = widget.prefs.getString(Prefs.tokenId);
      String webSocketUrl = '${Constants.urlWebSocket}?access_token=$tokenId';
      _stompClient = WebSocketUtils.connect(webSocketUrl, (frame) {
        _stompClient?.subscribe(
            destination: '${Constants.topicTokenIssuedUid}/$uid',
            callback: (frame) async {
              String? jsonText = frame.body;
              if (jsonText != null) {
                List<TokenIssuedModel> issuedList = [];
                List<dynamic> list = jsonDecode(jsonText);
                for (dynamic item in list) {
                  TokenIssuedModel tokenIssued = TokenIssuedModel.fromMap(item);
                  issuedList.add(tokenIssued);
                }
                final List<TokenIssuedModel> listNew = issuedList
                    .whereNot((e) => e.statusName == Status.completed)
                    .toList();
                issuedList.sortDescByNullable<num>((e) => e.modifiedDate);
                _tokenIssuedList = listNew.toList();
                if (issuedList.isNotEmpty) {
                  final tokenLatest = issuedList.first;
                  String body =
                      '${tokenLatest.tokenLetter}-${tokenLatest.tokenNumber}, STATUS: ${tokenLatest.statusName}';
                  await AppUtils.showNotification(
                      flutterLocalNotificationsPlugin, 1, 'Token Status', body);
                }
                setState(() {});
              }
            });
      }, headers);
      if (_stompClient?.isActive == false) {
        _stompClient?.activate();
      }
    }
  }

  @override
  void dispose() {
    _searchBizController.dispose();
    _stompClient?.deactivate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? styleMedium = Theme.of(context).textTheme.headlineMedium;
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    if (width > ScreenProp.widthPhoneScreenLimit) {
      width = ScreenProp.widthPhoneScreenLimit;
    }
    return Center(
      child: Container(
        alignment: Alignment.topCenter,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Header(
                backgroundColor: Colors.redAccent,
                fontColor: Colors.white,
              ),
              const SizedBox(height: 8),
              BlocBuilder<TokenBloc, TokenState>(
                builder: (context, state) {
                  if (state is TokenLoadedVisitorState) {
                    _tokenIssuedList = state.tokens;
                  }
                  _tokenIssuedList
                      ?.sortDescByNullable<num>((e) => e.modifiedDate);
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            if (_tokenIssuedList?.isEmpty == true) ...[
                              DottedBorder(
                                  color: Colors.orangeAccent,
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(12),
                                  dashPattern: const [6, 4, 6, 4],
                                  padding: const EdgeInsets.all(4),
                                  strokeWidth: 2,
                                  child: Container(
                                    width: 300,
                                    height: 100,
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        color: Colors.blueAccent.shade100,
                                        borderRadius:
                                            const BorderRadius.all(
                                          Radius.circular(12),
                                        )),
                                    child: Center(
                                        child: ListTile(
                                      title: Text(S.of(context).emptyToken,
                                          style: styleMedium?.apply(
                                              color: Colors.white)),
                                      subtitle: Text(S
                                          .of(context)
                                          .shouldCreateNewToken),
                                    )),
                                  )),
                            ],
                            for (TokenIssuedModel issued
                                in _tokenIssuedList ?? []) ...[
                              const SizedBox(width: 8),
                              _buildItem(issued),
                              const SizedBox(width: 2),
                            ]
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _searchBizController,
                        decoration: DecoratorUtils.inputDecoration(
                            S.of(context).search,
                            prefixIcon: CupertinoIcons.search,
                            suffixIcon: CupertinoIcons.xmark,
                            clear: () async {
                          _searchBizController.clear();
                          context.read<BizBloc>().add(BizLoadAllEvent(
                              page: 0,
                              pageSize: 10,
                              sortBy: 'bizLevel,modifiedDate,desc',
                              enable: true));
                        }),
                        onFieldSubmitted: (value) async {
                          if (value.isNotEmpty) {
                            context
                                .read<BizBloc>()
                                .add(BizSearchEvent(text: value));
                          } else {
                            context.read<BizBloc>().add(BizLoadAllEvent(
                                page: 0,
                                pageSize: 10,
                                sortBy: 'bizLevel,modifiedDate,desc',
                                enable: true));
                          }
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(CupertinoIcons.qrcode_viewfinder),
                      onPressed: () async {
                        await Utils.pushPage(
                            context,
                            ScannerScreen(
                              prefs: widget.prefs,
                              back: WayScreen(prefs: widget.prefs),
                              actionCallback: _actionCallback,
                              live: Utils.isMobileNotBrowser,
                            ),
                            'ScannerScreen');
                      },
                    ),
                  ],
                ),
              ),
              BlocBuilder<BizBloc, BizState>(builder: (context, state) {
                if (state is BizLoadedState) {
                  _bizs = state.bizs;
                }
                if (_bizs?.isEmpty == true) {
                  return const NoData();
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      for (ProfileBizModel biz in _bizs ?? []) ...[
                        _buildItemBiz(biz),
                      ]
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemBiz(ProfileBizModel biz) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: ListTile(
        shape: const ContinuousRectangleBorder(
            side: BorderSide(color: Colors.grey)),
        contentPadding: EdgeInsets.zero,
        leading: ClipOval(
          child: Container(
            width: 60,
            height: 60,
            padding: const EdgeInsets.all(10.0),
            child: (biz.bizLogoBase64?.isNotEmpty == true)
                ? Image.memory(base64Decode(biz.bizLogoBase64 ?? ''))
                : Image.asset('assets/images/1024.png'),
          ),
        ),
        title: Text(biz.bizName ?? ''),
        trailing: IconButton(
          icon: const Icon(CupertinoIcons.ellipsis_vertical_circle),
          onPressed: () async{
            await Utils.pushPage(
                context, BizScreen(prefs: widget.prefs, biz: biz), 'BizScreen');
          },
        ),
        onTap: () async{
          context.read<DepartmentBloc>().add(DepartmentByBizEvent(biz: biz, enable: true));
          await Utils.pushPage(
              context,
              DepartmentScreen(prefs: widget.prefs),
              'DepartmentScreen');
        },
      ),
    );
  }

  Widget _buildItem(TokenIssuedModel issued) {
    TextStyle? styleMedium = Theme.of(context).textTheme.headlineMedium;
    TextStyle? styleLabelSmall = Theme.of(context).textTheme.labelSmall;
    ProfileBizModel? biz = issued.profileBiz;
    return DottedBorder(
      color: Colors.orangeAccent,
      borderType: BorderType.RRect,
      radius: const Radius.circular(12),
      dashPattern: const [6, 4, 6, 4],
      padding: const EdgeInsets.all(4),
      strokeWidth: 2,
      child: Container(
          width: 300,
          height: 120,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: Colors.yellowAccent.shade100,
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              )),
          child: Center(
            child: ListTile(
              leading: Utils.getStatusLeading(issued),
              title: FittedBox(
                  child: Text('${issued.tokenLetter}-${issued.tokenNumber}',
                      style: styleMedium?.apply(color: Colors.black))),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (biz != null) ...[
                    Text(biz.bizName ?? '',
                        style: styleLabelSmall?.apply(color: Colors.black)),
                  ],
                  const SizedBox(height: 4),
                  Text(issued.departmentName ?? '',
                      style: styleLabelSmall?.apply(color: Colors.black)),
                  if (issued.statusName == Status.onqueue) ...[
                    Text('${issued.terminalName}',
                        style: styleLabelSmall?.apply(color: Colors.black)),
                  ],
                  const SizedBox(height: 4),
                  Text(Utils.printAgo(issued.createdDate, 'en')),
                ],
              ),
              isThreeLine: true,
              trailing: IconButton(
                icon: const Icon(CupertinoIcons.info_circle_fill),
                onPressed: () async{
                  if (biz != null) {
                    await Utils.pushPage(context,
                        BizScreen(prefs: widget.prefs, biz: biz), 'BizScreen');
                  }
                },
              ),
              onTap: () async{
                int? id = issued.id;
                if (id == null) return;
                context.read<TokenBloc>().add(TokenLoadOneEvent(id: id));
                await Utils.pushPage(
                    context,
                    TokenScreen(
                      prefs: widget.prefs, 
                      homeScreen: WayScreen(prefs: widget.prefs),
                    ),
                    'TokenScreen'
                );
              },
            ),
          )),
    );
  }

  Future<void> _actionCallback(
      String text, QRCodeDartScanController? controller) async {
    Logger.log(tag, message: 'text: $text');
    if (text.length < Constants.qrPrefixDepartment.length) {
      Utils.overlayInfoMessage(msg: S.of(context).invalid);
      return;
    }
    String str = Utils.retriveQrCodeId(text, Constants.qrPrefixDepartment);
    Logger.log(tag, message: 'str: $str');
    String sDepId = str.substring(0, str.indexOf('-'));
    String sBanner = str.substring(str.indexOf('-') + 1, str.length);
    int? depId = int.tryParse(sDepId);
    if (depId == null) return;
    Navigator.of(context).pop();

    context.read<DepartmentBloc>().add(DepartmentWithQrEvent(
        depId: depId,
        banner: sBanner,
        controller: controller));
    await Utils.pushPage(context, DepartmentScreen(prefs: widget.prefs), 'DepartmentScreen');
  }
}
