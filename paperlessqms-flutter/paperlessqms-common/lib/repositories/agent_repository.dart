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
import 'package:common/models/agent_model.dart';
import 'package:common/models/profile_biz_model.dart';
import 'package:common/models/server_error_model.dart';
import 'package:common/services/rest_connect_service.dart';
import 'package:common/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AgentRepository {
  final SharedPreferences prefs;
  final BuildContext context;
  const AgentRepository({required this.context, required this.prefs});

  static RestConnectService restConnectService = locator<RestConnectService>();

  Future<dynamic> saveAgent(AgentModel? agent) async{
    dynamic checkResult = await restConnectService.postMethod(
      context, Constants.apiAgent,
      headers: PrefsUtils.getHeader(prefs),
      body: jsonEncode(agent),
    );
    final error = ServerErrorModel.fromMap(checkResult);
    if (error.data!=null) return error;
    return AgentModel.fromMap(checkResult);
  }

  Future<dynamic> updateAgent(AgentModel? agent) async{
    if (agent==null) return null;
    final result = await restConnectService.putMethod(
      context, 
      '${Constants.apiAgent}/${agent.id}',
      headers: PrefsUtils.getHeader(prefs),
      body: jsonEncode(agent.toJson())
    );
    final error = ServerErrorModel.fromMap(result);
    if (error.data!=null) return error;
    return AgentModel.fromMap(result);
  }

  Future<dynamic> getAgentList(ProfileBizModel? profileBiz, {bool? enable}) async{
    if (profileBiz==null){
      return null;
    } 
    String filter = (enable!=null)?'&enable.equals=$enable':'';
    dynamic result = await restConnectService.getMethod(
      context, '${Constants.apiAgent}?profileBizId.equals=${profileBiz.id}$filter',
      headers: PrefsUtils.getHeader(prefs));
    final error = ServerErrorModel.fromMap(result);
    if (error.data!=null) return error;
    if (result.isNotEmpty){
      List<AgentModel> list = [];
      for (Map e in result) {
        AgentModel agent = AgentModel.fromMap(e);
        list.add(agent);
      }      
      return list;
    }
    return null;
  }

  Future<dynamic> findAgentByLogin(String? login) async{
    if (login==null){
      return null;
    }    
    List<AgentModel> list = [];
    dynamic checkResult = await restConnectService.getMethod(
      context, '${Constants.apiAgent}?login.equals=$login',
      headers: PrefsUtils.getHeader(prefs));
    final error = ServerErrorModel.fromMap(checkResult);
    if (error.data!=null) return error;
    if (checkResult.isNotEmpty){
      for (var result in checkResult) {
        AgentModel agent = AgentModel.fromMap(result);
        list.add(agent);
      }      
      return list;
    }
    return null;
  }

  Future<int> countAgentByDepartmentAndTerminal(String? login, int? depId, int? terId) async{
    if (login==null || depId==null || terId==null){
      return 0;
    }    
    dynamic checkResult = await restConnectService.getMethod(
      context, '${Constants.apiAgent}/count?login.equals=$login&queueDepartmentId.equals=$depId&queueTerminalId.equals=$terId',
      headers: PrefsUtils.getHeader(prefs));
    return checkResult;
  }

  Future<dynamic> getAgent(int? id) async{
    if (id==null){
      return null;
    }    
    dynamic checkResult = await restConnectService.getMethod(
      context, '${Constants.apiAgent}/$id',
      headers: PrefsUtils.getHeader(prefs));
    final error = ServerErrorModel.fromMap(checkResult);
    if (error.data!=null) return error;
    if (checkResult!=null){
      AgentModel agent = AgentModel.fromMap(checkResult);
      return agent;
    }
    return null;
  }

  Future<dynamic> deleteAgent(AgentModel? agent) async{
    if (agent==null) return null;
    dynamic result = await restConnectService.deleteMethod(
      context, 
      '${Constants.apiAgent}/${agent.id}',
      headers: PrefsUtils.getHeader(prefs),
    );
    final error = ServerErrorModel.fromMap(result);
    if (error.data!=null) return error;
    return result;
  }
  
  Future<dynamic> findAgentByDepartment(
        int? departmentId, {bool? enable}) async{
    if (departmentId==null) return null;
    String filter = (enable!=null)?'&enable.equals=$enable':'';
    dynamic result = await restConnectService.getMethod(
      context, 
      '${Constants.apiAgent}?queueDepartmentId.equals=$departmentId$filter',
      headers: PrefsUtils.getHeader(prefs),
    );
    final error = ServerErrorModel.fromMap(result);
    if (error.data!=null) return error;
    List<AgentModel> list = [];
    for (Map e in result) {
      list.add(AgentModel.fromMap(e));
    }
    return list;
  }

  Future<dynamic> findAgentByTerminal(
        int? terminalId, {bool? enable}) async{
    if (terminalId==null) return null;
    String filter = (enable!=null)?'&enable.equals=$enable':'';
    dynamic result = await restConnectService.getMethod(
      context, 
      '${Constants.apiAgent}?queueTerminalId.equals=$terminalId$filter',
      headers: PrefsUtils.getHeader(prefs),
    );
    final error = ServerErrorModel.fromMap(result);
    if (error.data!=null) return error;
    List<AgentModel> list = [];
    for (Map e in result) {
      list.add(AgentModel.fromMap(e));
    }
    return list;
  }
}