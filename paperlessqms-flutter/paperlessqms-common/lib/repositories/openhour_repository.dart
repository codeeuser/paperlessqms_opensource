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
import 'package:common/models/openhour_model.dart';
import 'package:common/models/profile_biz_model.dart';
import 'package:common/models/server_error_model.dart';
import 'package:common/services/rest_connect_service.dart';
import 'package:common/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OpenhourRepository {
  final SharedPreferences prefs;
  final BuildContext context;
  const OpenhourRepository({required this.context, required this.prefs});

  static RestConnectService restConnectService = locator<RestConnectService>();

  Future<dynamic> saveOpenhour(OpenhourModel? openhour) async{
    dynamic checkResult = await restConnectService.postMethod(
      context, Constants.apiOpenhour,
      headers: PrefsUtils.getHeader(prefs),
      body: jsonEncode(openhour),
    );
    final error = ServerErrorModel.fromMap(checkResult);
    if (error.data!=null) return error;
    return OpenhourModel.fromMap(checkResult);
  }

  Future<dynamic> updateOpenhour(OpenhourModel? openhour) async{
    if (openhour==null) return null;
    final result = await restConnectService.putMethod(
      context, 
      '${Constants.apiOpenhour}/${openhour.id}',
      headers: PrefsUtils.getHeader(prefs),
      body: jsonEncode(openhour.toJson())
    );
    final error = ServerErrorModel.fromMap(result);
    if (error.data!=null) return error;
    return OpenhourModel.fromMap(result);
  }

  Future<dynamic> getOpenhourList(ProfileBizModel? profileBiz) async{
    if (profileBiz==null){
      return null;
    } 
    List<dynamic> checkResult = await restConnectService.getMethod(
      context, '${Constants.apiOpenhour}?profileBizId.equals=${profileBiz.id}',
      headers: PrefsUtils.getHeader(prefs));
    final error = ServerErrorModel.fromMap(checkResult);
    if (error.data!=null) return error;
    if (checkResult.isNotEmpty){
      List<OpenhourModel> list = [];
      for (Map e in checkResult) {
        OpenhourModel openhour = OpenhourModel.fromMap(e);
        list.add(openhour);
      }      
      return list;
    }
    return null;
  }

  Future<dynamic> getOpenhour(int? id) async{
    if (id==null){
      return null;
    }    
    dynamic checkResult = await restConnectService.getMethod(
      context, '${Constants.apiOpenhour}/$id',
      headers: PrefsUtils.getHeader(prefs));
    final error = ServerErrorModel.fromMap(checkResult);
    if (error.data!=null) return error;
    if (checkResult!=null){
      OpenhourModel openhour = OpenhourModel.fromMap(checkResult);
      return openhour;
    }
    return null;
  }

  Future<dynamic> deleteOpenhour(OpenhourModel? openhour) async{
    if (openhour==null) return null;
    dynamic result = await restConnectService.deleteMethod(
      context, 
      '${Constants.apiOpenhour}/${openhour.id}',
      headers: PrefsUtils.getHeader(prefs),
    );
    final error = ServerErrorModel.fromMap(result);
    if (error.data!=null) return error;
    return result;
  }

  Future<dynamic> findOpenhourByBizAndDay(
        ProfileBizModel? biz, int dayNum, {bool? enable}) async{
    if (biz==null || biz.id==null) return null;
    String filter = (enable!=null)?'&enable.equals=$enable':'';
    filter += '&dayNum.equals=$dayNum';
    dynamic result = await restConnectService.getMethod(
      context, 
      '${Constants.apiOpenhour}?profileBizId.equals=${biz.id}$filter',
      headers: PrefsUtils.getHeader(prefs),
    );
    final error = ServerErrorModel.fromMap(result);
    if (error.data!=null) return error;
    List<OpenhourModel> list = [];
    for (Map e in result) {
      list.add(OpenhourModel.fromMap(e));
    }
    return list;
  }

  Future<dynamic> findOpenhourByBiz(
        ProfileBizModel? biz, {bool? enable}) async{
    if (biz==null || biz.id==null) return null;
    String filter = (enable!=null)?'&enable.equals=$enable':'';
    dynamic result = await restConnectService.getMethod(
      context, 
      '${Constants.apiOpenhour}?profileBizId.equals=${biz.id}$filter',
      headers: PrefsUtils.getHeader(prefs),
    );
    final error = ServerErrorModel.fromMap(result);
    if (error.data!=null) return error;
    List<OpenhourModel> list = [];
    for (Map e in result) {
      list.add(OpenhourModel.fromMap(e));
    }
    return list;
  }
}