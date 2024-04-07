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

import 'package:common/locator.dart';
import 'package:common/models/maxtoken_model.dart';
import 'package:common/models/profile_biz_model.dart';
import 'package:common/models/server_error_model.dart';
import 'package:common/services/rest_connect_service.dart';
import 'package:common/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MaxtokenRepository {
  final SharedPreferences prefs;
  final BuildContext context;
  const MaxtokenRepository({required this.context, required this.prefs});

  static RestConnectService restConnectService = locator<RestConnectService>();

  Future<dynamic> saveMaxtoken(MaxtokenModel? maxtoken) async{
    dynamic checkResult = await restConnectService.postMethod(
      context, Constants.apiMaxtoken,
      headers: PrefsUtils.getHeader(prefs),
      body: jsonEncode(maxtoken),
    );
    final error = ServerErrorModel.fromMap(checkResult);
    if (error.data!=null) return error;
    return MaxtokenModel.fromMap(checkResult);
  }

  Future<dynamic> updateMaxtoken(MaxtokenModel? maxtoken) async{
    if (maxtoken==null) return null;
    final result = await restConnectService.putMethod(
      context, 
      '${Constants.apiMaxtoken}/${maxtoken.id}',
      headers: PrefsUtils.getHeader(prefs),
      body: jsonEncode(maxtoken.toJson())
    );
    final error = ServerErrorModel.fromMap(result);
    if (error.data!=null) return error;
    return MaxtokenModel.fromMap(result);
  }

  Future<dynamic> getMaxtokenList(ProfileBizModel? profileBiz) async{
    if (profileBiz==null){
      return null;
    } 
    List<dynamic> checkResult = await restConnectService.getMethod(
      context, '${Constants.apiMaxtoken}?profileBizId.equals=${profileBiz.id}',
      headers: PrefsUtils.getHeader(prefs));
    final error = ServerErrorModel.fromMap(checkResult);
    if (error.data!=null) return error;
    if (checkResult.isNotEmpty){
      List<MaxtokenModel> list = [];
      for (Map e in checkResult) {
        MaxtokenModel maxtoken = MaxtokenModel.fromMap(e);
        list.add(maxtoken);
      }      
      return list;
    }
    return null;
  }

  Future<dynamic> getMaxtoken(int? id) async{
    if (id==null){
      return null;
    }    
    dynamic checkResult = await restConnectService.getMethod(
      context, '${Constants.apiMaxtoken}/$id',
      headers: PrefsUtils.getHeader(prefs));
    final error = ServerErrorModel.fromMap(checkResult);
    if (error.data!=null) return error;
    if (checkResult!=null){
      MaxtokenModel maxtoken = MaxtokenModel.fromMap(checkResult);
      return maxtoken;
    }
    return null;
  }

  Future<dynamic> deleteMaxtoken(MaxtokenModel? maxtoken) async{
    if (maxtoken==null) return null;
    dynamic result = await restConnectService.deleteMethod(
      context, 
      '${Constants.apiMaxtoken}/${maxtoken.id}',
      headers: PrefsUtils.getHeader(prefs),
    );
    final error = ServerErrorModel.fromMap(result);
    if (error.data!=null) return error;
    return result;
  }

  Future<dynamic> findMaxtokenByBizAndDay(
        ProfileBizModel? biz, int dayNum, {bool? enable}) async{
    if (biz==null || biz.id==null) return null;
    String filter = (enable!=null)?'&enable.equals=$enable':'';
    filter += '&dayNum.equals=$dayNum';
    dynamic result = await restConnectService.getMethod(
      context, 
      '${Constants.apiMaxtoken}?profileBizId.equals=${biz.id}$filter',
      headers: PrefsUtils.getHeader(prefs),
    );
    final error = ServerErrorModel.fromMap(result);
    if (error.data!=null) return error;
    List<MaxtokenModel> list = [];
    for (Map e in result) {
      list.add(MaxtokenModel.fromMap(e));
    }
    return list;
  }

  Future<dynamic> findMaxtokenByBiz(
        ProfileBizModel? biz, {bool? enable}) async{
    if (biz==null || biz.id==null) return null;
    String filter = (enable!=null)?'&enable.equals=$enable':'';
    dynamic result = await restConnectService.getMethod(
      context, 
      '${Constants.apiMaxtoken}?profileBizId.equals=${biz.id}$filter',
      headers: PrefsUtils.getHeader(prefs),
    );
    final error = ServerErrorModel.fromMap(result);
    if (error.data!=null) return error;
    List<MaxtokenModel> list = [];
    for (Map e in result) {
      list.add(MaxtokenModel.fromMap(e));
    }
    return list;
  }
}