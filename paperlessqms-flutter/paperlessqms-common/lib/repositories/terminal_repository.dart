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
import 'package:common/models/profile_biz_model.dart';
import 'package:common/models/queue_department_model.dart';
import 'package:common/models/queue_service_model.dart';
import 'package:common/models/queue_terminal_model.dart';
import 'package:common/models/server_error_model.dart';
import 'package:common/services/rest_connect_service.dart';
import 'package:common/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TerminalRepository {
  final SharedPreferences prefs;
  final BuildContext context;
  const TerminalRepository({required this.context, required this.prefs});

  static RestConnectService restConnectService = locator<RestConnectService>();

  Future<dynamic> findTerminalByDepartment(QueueDepartmentModel? dep, {bool? enable}) async{
    if (dep==null || dep.id==null) return null;
    String filter = (enable!=null)?'&enable.equals=$enable':'';
    dynamic result = await restConnectService.getMethod(
      context, 
      '${Constants.apiTerminal}?queueDepartmentId.equals=${dep.id}$filter',
      headers: PrefsUtils.getHeader(prefs),
    );
    final error = ServerErrorModel.fromMap(result);
    if (error.data!=null) return error;
    List<QueueTerminalModel> list = [];
    for (Map e in result) {
      list.add(QueueTerminalModel.fromMap(e));
    }
    return list;
  }


  Future<dynamic> findTerminalByService(QueueServiceModel? service, {bool? enable}) async{
    if (service==null || service.id==null) return null;
    String filter = (enable!=null)?'&enable.equals=$enable':'';
    dynamic result = await restConnectService.getMethod(
      context, 
      '${Constants.apiTerminal}?queueServiceId.equals=${service.id}$filter',
      headers: PrefsUtils.getHeader(prefs),
    );
    final error = ServerErrorModel.fromMap(result);
    if (error.data!=null) return error;
    List<QueueTerminalModel> list = [];
    for (Map e in result) {
      list.add(QueueTerminalModel.fromMap(e));
    }
    return list;
  }

  Future<dynamic> getQueueTerminalList(ProfileBizModel? profileBiz) async{
    if (profileBiz==null){
      return null;
    } 
    dynamic checkResult = await restConnectService.getMethod(
      context, '${Constants.apiTerminal}?profileBizId.equals=${profileBiz.id}',
      headers: PrefsUtils.getHeader(prefs));
    final error = ServerErrorModel.fromMap(checkResult);
    if (error.data!=null) return error;
    if (checkResult.isNotEmpty){
      List<QueueTerminalModel> list = [];
      for (var e in checkResult) {
        QueueTerminalModel queueTerminal = QueueTerminalModel.fromMap(e);
        list.add(queueTerminal);
      }     
      return list;
    }
    return null;
  }

  Future<dynamic> getQueueTerminal(int? id) async{
    if (id==null){
      return null;
    }    
    dynamic checkResult = await restConnectService.getMethod(
      context, '${Constants.apiTerminal}/$id',
      headers: PrefsUtils.getHeader(prefs));
    final error = ServerErrorModel.fromMap(checkResult);
    if (error.data!=null) return error;
    if (checkResult!=null){
      QueueTerminalModel queueTerminal = QueueTerminalModel.fromMap(checkResult);
      return queueTerminal;
    }
    return null;
  }

  Future<dynamic> saveTerminal(QueueTerminalModel? terminal) async{
    if (terminal==null) return null;
    final result = await restConnectService.postMethod(
      context, 
      Constants.apiTerminal,
      headers: PrefsUtils.getHeader(prefs),
      body: jsonEncode(terminal.toJson())
    );
    final error = ServerErrorModel.fromMap(result);
    if (error.data!=null) return error;
    return QueueTerminalModel.fromMap(result);
  }

  Future<dynamic> updateTerminal(QueueTerminalModel? terminal) async{
    if (terminal==null) return null;
    final result = await restConnectService.putMethod(
      context, 
      '${Constants.apiTerminal}/${terminal.id}',
      headers: PrefsUtils.getHeader(prefs),
      body: jsonEncode(terminal.toJson())
    );
    final error = ServerErrorModel.fromMap(result);
    if (error.data!=null) return error;
    return QueueTerminalModel.fromMap(result);
  }

  Future<dynamic> deleteTerminal(QueueTerminalModel? terminal) async{
    if (terminal==null) return null;
    dynamic result = await restConnectService.deleteMethod(
      context, 
      '${Constants.apiTerminal}/${terminal.id}',
      headers: PrefsUtils.getHeader(prefs),
    );
    final error = ServerErrorModel.fromMap(result);
    if (error.data!=null) return error;
    return result;
  }
}