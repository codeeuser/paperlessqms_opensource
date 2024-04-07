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

import 'package:common/bloc/agent_bloc.dart';
import 'package:common/bloc/biz_bloc.dart';
import 'package:common/bloc/department_bloc.dart';
import 'package:common/bloc/maxtoken_bloc.dart';
import 'package:common/bloc/openhour_bloc.dart';
import 'package:common/bloc/service_bloc.dart';
import 'package:common/bloc/terminal_bloc.dart';
import 'package:common/bloc/token_bloc.dart';
import 'package:common/models/account_model.dart';
import 'package:common/models/header_model.dart';
import 'package:common/utils/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../config.dart';

enum ActionPage {list, newItem}
enum QmsPlatform {client, call, admin}
class Prefs {
  static const String themeMode = "themeMode";
  static const String appReview = "appReview";
  static const String tokenId = "tokenId";
  static const String account = "account";
  static const String emailLogin = "emailLogin";
  static const String recaptcha = "recaptcha";
}

class Constants{
  static const String password = r'C4x*$TwbkJC-xK4KGC4zJF9j*Rh&WLgR';
  static const String indent = '\t\t\t';
  static const int delayLoadTime = 300;
  static const loginTime = Duration(seconds: 1);
  static const divider = Divider(color: Colors.grey);
  static const String qrPrefixTokenIssuded = 'ti_';
  static const String qrPrefixDepartment = 'dep_';

  static const urlWebSocket = '$protocol://$domainName/websocket/tracker';
  static const String topicTokenIssuedUid = '/topic/tokenIssuedUid';
  static const String topicTokenIssuedId = '/topic/tokenIssuedId';
  static const String topicRunningToken = '/topic/runningToken';
  static const String topicCountCall = '/topic/countCall';
  static const String topicCountList = '/topic/countList';

  static const apiAuth = '$protocol://$domainName/api/authenticate';
  static const apiAccount = '$protocol://$domainName/api/account';
  static const apiUser = '$protocol://$domainName/api/admin/users';
  static const apiRegister = '$protocol://$domainName/api/register';
  static const apiBusiness = '$protocol://$domainName/api/profile-bizs';
  static const apiDepartment = '$protocol://$domainName/api/queue-departments';
  static const apiService = '$protocol://$domainName/api/queue-services';
  static const apiAgent = '$protocol://$domainName/api/agents';
  static const apiTerminal = '$protocol://$domainName/api/queue-terminals';
  static const apiTokenNumber = '$protocol://$domainName/api/token-numbers';
  static const apiTokenIssued = '$protocol://$domainName/api/token-issueds';
  static const apiCatalog = '$protocol://$domainName/api/catalogs';
  static const apiCategory = '$protocol://$domainName/api/categories';
  static const apiOpenhour = '$protocol://$domainName/api/open-hours';
  static const apiMaxtoken = '$protocol://$domainName/api/max-tokens';
}

class DayMap {
  static const Map<int, String> short = {
    1: 'Mon',
    2: 'Tue',
    3: 'Web',
    4: 'Thu',
    5: 'Fri',
    6: 'Sat',
    7: 'Sun',
  };
  static const Map<int, String> long = {
    1: 'Monday',
    2: 'Tuesday',
    3: 'Webnesday',
    4: 'Thuesday',
    5: 'Friday',
    6: 'Saturday',
    7: 'Sunday',
  };
}

class StatusAcronym {
  static const String onwait = "W";
  static const String onqueue = "Q";
  static const String completed = "C";
  static const String recall = "R";  
  static const String timeout = "T"; 
  static const String transfer = "F"; 
  static const String cancel = "L"; 
}

class Status {
  static const String onwait = "Waiting";
  static const String onqueue = "Queueing";
  static const String completed = "Completed";
  static const String recall = "Recall";  
  static const String timeout = "Timeout";
  static const String transfer = "Transfer";
  static const String cancel = "Cancel";
}

class StatusCode {
  static const int onwait = 100;
  static const int onqueue = 200;
  static const int recall = 300;  
  static const int completed = 400;
  static const int timeout = 500;
  static const int transfer = 600;
  static const int cancel = 700;
}

class StatusColor {
  static const Color onwait = Colors.orange;
  static const Color onqueue = Colors.green;
  static const Color recall = Colors.red;  
  static const Color completed = Colors.blue;
  static const Color timeout = Colors.pinkAccent;
  static const Color transfer = Colors.indigo;
  static const Color cancel = Colors.grey;
}

class RatingCode {
  static const int one = 1;
  static const int two = 2;
  static const int three = 3;  
  static const int four = 4;
  static const int five = 5;
}

class RatingColor {
  static const Color one = Colors.green;
  static const Color two = Colors.orange;
  static const Color three = Colors.blue;  
  static const Color four = Colors.indigo;
  static const Color five = Colors.pinkAccent;
}

class PrefsUtils {
  static List<HeaderModel>? getHeader(SharedPreferences prefs){
    String? tokenId = prefs.getString(Prefs.tokenId);
    if (tokenId==null){
      return null;
    }
    List<HeaderModel>? headers = [
      HeaderModel(key: uuid.v4(), name: 'Authorization', value: 'Bearer $tokenId')
    ];
    return headers;
  }

  static AccountModel? getAccount(SharedPreferences prefs){
    String? accountJson = prefs.getString(Prefs.account);
    if (accountJson==null){
      return null;
    }
    AccountModel account = AccountModel.fromMap(jsonDecode(accountJson));
    return account;
  }

  static Future<void> saveEmailLogin(SharedPreferences prefs, String email) async{
    await prefs.setString(Prefs.emailLogin, email);
  }

  static Future<void> signout(BuildContext context, SharedPreferences prefs) async{
    await prefs.remove(Prefs.tokenId);
    await prefs.remove(Prefs.account);
    await prefs.remove(Prefs.recaptcha);
    context.read<BizBloc>().add(BizResetEvent());
    CommonUtils.resetBlocState(context);
  }
}


class CommonUtils{

  static void resetBlocState(BuildContext context){
    context.read<AgentBloc>().add(AgentResetEvent());
    context.read<DepartmentBloc>().add(DepartmentResetEvent());
    context.read<MaxtokenBloc>().add(MaxtokenResetEvent());
    context.read<OpenhourBloc>().add(OpenhourResetEvent());
    context.read<ServiceBloc>().add(ServiceResetEvent());
    context.read<TerminalBloc>().add(TerminalResetEvent());
    context.read<TokenBloc>().add(TokenResetEvent());
  }

  static Widget actionBar(BuildContext context, {String? title, Function? back, Function? save}){
    TextStyle? style = Theme.of(context).textTheme.headlineSmall;
    return Container(
      decoration: DecoratorUtils.actionBar(),
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton.outlined(
            icon: const Icon(CupertinoIcons.chevron_left),
            onPressed: (){
              if (back!=null){
                back();
              }
            },
          ),
          Text(title??'', style: style),
          IconButton.filled(
            icon: const Icon(CupertinoIcons.floppy_disk),
            onPressed: () async{
              if (save!=null){
                save();
              }
            },
          ),
        ],
      ),
    );
  }
}


const Uuid uuid = Uuid();
const statues4Call = [StatusCode.onwait, StatusCode.cancel];
const statues4Completed = [StatusCode.completed, StatusCode.timeout];
const statues4List = [StatusCode.onqueue, StatusCode.recall, StatusCode.transfer];

