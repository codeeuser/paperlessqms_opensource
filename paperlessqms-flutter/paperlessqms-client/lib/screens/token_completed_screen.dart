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

import 'package:client/logger.dart';
import 'package:client/screens/feedback_screen.dart';
import 'package:common/bloc/token_bloc.dart';
import 'package:common/generated/l10n.dart';
import 'package:common/models/account_model.dart';
import 'package:common/models/token_issued_model.dart';
import 'package:common/utils/constants.dart';
import 'package:common/utils/functions.dart';
import 'package:common/utils/no_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenCompletedScreen extends StatefulWidget {
  final SharedPreferences prefs;
  const TokenCompletedScreen({super.key, required this.prefs});

  @override
  State<TokenCompletedScreen> createState() => _TokenCompletedScreenState();
}

class _TokenCompletedScreenState extends State<TokenCompletedScreen> {
  static const String tag = 'TokenCompletedScreen';

  List<TokenIssuedModel>? _tokenList;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    Logger.log(tag, message: '_initialize---');
    AccountModel account = PrefsUtils.getAccount(widget.prefs)?? AccountModel();
    final accountId = account.id;
    if (accountId!=null){
      context.read<TokenBloc>().add(
        TokenByUidWithStatusEvent(
          uid: accountId, 
          statues: statues4Completed, 
          reset: false,
          page: 0,
          pageSize: 20,
          sortBy: 'modifiedDate,desc',
        )
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    if (width>ScreenProp.widthPhoneScreenLimit){
      width = ScreenProp.widthPhoneScreenLimit;
    }
    return BlocBuilder<TokenBloc, TokenState>(
      builder: (context, state){
        Logger.log(tag, message: 'TokenState: $state');
        if (state is TokenLoadedVisitorState){
          _tokenList = state.tokens;
        }
        return SafeArea(
          child: Center(
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
                    if (_tokenList?.isEmpty==true)...[
                      const NoData(),
                    ] else ...[
                      Constants.divider,
                      for(TokenIssuedModel issued in _tokenList??[])...[
                        ListTile(
                          leading: Utils.getStatusLeading(issued),
                          title: Text('${issued.tokenLetter}-${issued.tokenNumber}'), 
                          trailing: (issued.statusCode==StatusCode.completed)? IconButton(
                            icon: const Icon(CupertinoIcons.rectangle_badge_checkmark),
                            onPressed: () async{
                              await _showFeedback(issued);
                            },
                          ): null,
                          subtitle: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [                        
                                    ChoiceChip(
                                      label: Text(issued.serviceName??''),
                                      avatar: const Icon(CupertinoIcons.cursor_rays),
                                      selected: false,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(Utils.printAgo(issued.createdDate, 'en')),
                                  ],
                                ),
                                Text("${S.of(context).status}: ${issued.statusName??''}"),
                              ],
                            ),
                          ),
                        ),
                        Constants.divider,
                      ],
                    ],                    
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
  
  Future<void> _showFeedback(TokenIssuedModel issued) async{
    Utils.pushPage(context, FeedbackScreen(prefs: widget.prefs, issued: issued), 'FeedbackScreen');
  }
}