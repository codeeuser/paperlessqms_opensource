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
import 'package:common/models/queue_department_model.dart';
import 'package:common/models/queue_service_model.dart';
import 'package:common/models/server_error_model.dart';
import 'package:common/models/token_number_model.dart';
import 'package:common/services/rest_connect_service.dart';
import 'package:common/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NumberRepository {
  final SharedPreferences prefs;
  final BuildContext context;
  const NumberRepository({required this.context, required this.prefs});

  static RestConnectService restConnectService = locator<RestConnectService>();

  Future<dynamic> findTokenNumberByDepartment(
        QueueDepartmentModel? dep, {bool? reset}) async{
    if (dep==null || dep.id==null) return null;
    String filter = (reset!=null)?'&reset.equals=$reset':'';
    dynamic result = await restConnectService.getMethod(
      context, 
      '${Constants.apiTokenNumber}?departmentId.equals=${dep.id}$filter',
      headers: PrefsUtils.getHeader(prefs),
    );
    final error = ServerErrorModel.fromMap(result);
    if (error.data!=null) return error;
    List<TokenNumberModel> list = [];
    for (Map e in result) {
      list.add(TokenNumberModel.fromMap(e));
    }
    return list;
  }

  Future<dynamic> countTokenNumberByDepartmentAndService(
        QueueDepartmentModel? dep, QueueServiceModel? ser, {bool? reset}) async{
    if (dep==null || dep.id==null || ser==null || ser.id==null) return null;
    String filter = (reset!=null)?'&reset.equals=$reset':'';
    dynamic result = await restConnectService.getMethod(
      context, 
      '${Constants.apiTokenNumber}/count?departmentId.equals=${dep.id}&serviceId.equals=${ser.id}$filter',
      headers: PrefsUtils.getHeader(prefs),
    );
    final error = ServerErrorModel.fromMap(result);
    if (error.data!=null) return error;
    return result;
  }

  Future<dynamic> nextTokenNumber(TokenNumberModel? token) async{
    if (token==null){
      return null;
    } 
    dynamic checkResult = await restConnectService.putMethod(
      context, '${Constants.apiTokenNumber}/next-number',
      headers: PrefsUtils.getHeader(prefs),
      body: jsonEncode(token),
    );
    final error = ServerErrorModel.fromMap(checkResult);
    if (error.data!=null) return error;
    return TokenNumberModel.fromMap(checkResult);
  }

  Future<dynamic> saveTokenNumber(TokenNumberModel? token) async{
    if (token==null){
      return null;
    } 
    dynamic checkResult = await restConnectService.postMethod(
      context, Constants.apiTokenNumber,
      headers: PrefsUtils.getHeader(prefs),
      body: jsonEncode(token),
    );
    final error = ServerErrorModel.fromMap(checkResult);
    if (error.data!=null) return error;
    return TokenNumberModel.fromMap(checkResult);
  } 

  Future<dynamic> updateTokenNumber(TokenNumberModel? token) async{
    if (token==null){
      return null;
    } 
    dynamic checkResult = await restConnectService.putMethod(
      context, '${Constants.apiTokenNumber}/${token.id}',
      headers: PrefsUtils.getHeader(prefs),
      body: jsonEncode(token),
    );
    final error = ServerErrorModel.fromMap(checkResult);
    if (error.data!=null) return error;
    return TokenNumberModel.fromMap(checkResult);
  } 
}