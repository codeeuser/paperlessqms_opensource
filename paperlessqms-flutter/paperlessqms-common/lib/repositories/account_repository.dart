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

import 'package:common/locator.dart';
import 'package:common/logger.dart';
import 'package:common/models/account_model.dart';
import 'package:common/models/change_password_model.dart';
import 'package:common/models/server_error_model.dart';
import 'package:common/services/rest_connect_service.dart';
import 'package:common/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountRepository {
  final SharedPreferences prefs;
  final BuildContext context;
  const AccountRepository({required this.context, required this.prefs});

  static const String tag = 'AccountRepository';
  static RestConnectService restConnectService = locator<RestConnectService>();

  Future<String?> auth(String? body) async{
    if (body==null) return null;
    dynamic result = await restConnectService.postMethod(
      context, 
      Constants.apiAuth,
      body: body
    );
    if (result!=null){
      String? idToken = result['id_token'];
      if (idToken==null) return null;

      return idToken;
    }
    return null;
  }
  
  Future<dynamic> resetPassword(String? body) async{
    if (body==null) return null;
    dynamic result = await restConnectService.postMethod(
      context, 
      '${Constants.apiAccount}/reset-password/init', 
      headers: PrefsUtils.getHeader(prefs),
      body: body,  
    );
    return result;
  }

  Future<dynamic> checkAccount() async{
    dynamic result = await restConnectService.getMethod(context, Constants.apiAccount, headers: PrefsUtils.getHeader(prefs));
    Logger.log(tag, message: 'checkAccount: $result');
    if (result!=null){
      final error = ServerErrorModel.fromMap(result);
      if (error.data!=null) return error;
      AccountModel account = AccountModel.fromMap(result);
      await prefs.setString(Prefs.account, jsonEncode(account.toJson()));
      return account;
    }
    return null;
  }

  Future<dynamic> getUser(String? login) async{
    if (login==null) return null;
    dynamic result = await restConnectService.getMethod(context, '${Constants.apiUser}/$login', headers: PrefsUtils.getHeader(prefs));
    Logger.log(tag, message: 'getUser: $result');
    if (result!=null){
      final error = ServerErrorModel.fromMap(result);
      if (error.data!=null) return error;
      AccountModel account = AccountModel.fromMap(result);
      return account;
    }
    return null;
  }

  Future<dynamic> register(String? body) async{
    dynamic checkResult = await restConnectService.postMethod(
      context, Constants.apiRegister,
      headers: PrefsUtils.getHeader(prefs),
      body: body,
    );
    return checkResult;
  }  

  Future<dynamic> updateAccount(AccountModel? account) async{
    if (account==null) return null;
    final result = await restConnectService.postMethod(
      context, 
      Constants.apiAccount,
      headers: PrefsUtils.getHeader(prefs),
      body: jsonEncode(account.toJson())
    );
    return result;
  }

  Future<dynamic> changePassword(ChangePasswordModel? change) async{
    if (change==null) return null;
    final result = await restConnectService.postMethod(
      context, 
      '${Constants.apiAccount}/change-password',
      headers: PrefsUtils.getHeader(prefs),
      body: jsonEncode(change.toJson())
    );
    return result;
  }

  Future<dynamic> deleteAccount(AccountModel? account) async{
    if (account==null) return null;
    dynamic result = await restConnectService.deleteMethod(
      context, 
      '${Constants.apiAccount}/${account.id}',
      headers: PrefsUtils.getHeader(prefs),
    );
    final error = ServerErrorModel.fromMap(result);
    if (error.data!=null) return error;
    return result;
  }
}