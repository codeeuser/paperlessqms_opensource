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
import 'package:common/models/server_error_model.dart';
import 'package:common/models/token_issued_model.dart';
import 'package:common/services/rest_connect_service.dart';
import 'package:common/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenRepository {
  final SharedPreferences prefs;
  final BuildContext context;
  const TokenRepository({required this.context, required this.prefs});

  static RestConnectService restConnectService = locator<RestConnectService>();

  Future<dynamic> getTokenIssued(int? id) async{
    if (id==null){
      return null;
    }    
    dynamic checkResult = await restConnectService.getMethod(
      context, '${Constants.apiTokenIssued}/$id',
      headers: PrefsUtils.getHeader(prefs));
    final error = ServerErrorModel.fromMap(checkResult);
    if (error.data!=null) return error;
    if (checkResult!=null){
      TokenIssuedModel issued = TokenIssuedModel.fromMap(checkResult);
      return issued;
    }
    return null;
  }

  Future<dynamic> saveTokenIssued(TokenIssuedModel? issued) async{
    if (issued==null){
      return null;
    } 
    dynamic checkResult = await restConnectService.postMethod(
      context, Constants.apiTokenIssued,
      headers: PrefsUtils.getHeader(prefs),
      body: jsonEncode(issued),
    );
    final error = ServerErrorModel.fromMap(checkResult);
    if (error.data!=null) return error;
    return TokenIssuedModel.fromMap(checkResult);
  }

  Future<dynamic> updateTokenIssued(TokenIssuedModel? issued) async{
    if (issued==null) return null;
    final result = await restConnectService.putMethod(
      context, 
      '${Constants.apiTokenIssued}/${issued.id}',
      headers: PrefsUtils.getHeader(prefs),
      body: jsonEncode(issued.toJson())
    );
    final error = ServerErrorModel.fromMap(result);
    if (error.data!=null) return error;
    return TokenIssuedModel.fromMap(result);
  }

  Future<dynamic> searchNumber(String? text, int? agentId, List<int>? statues, {bool? reset}) async{
    if (text==null || agentId==null || statues==null){
      return null;
    } 
    String filterStatus = statues.join(',');
    filterStatus = (filterStatus.isNotEmpty)? '&statusCode.in=$filterStatus': '';
    String filterReset = (reset!=null)?'&reset.equals=$reset':'';
    String filterSearch = (text.isNotEmpty)?'&tokenNumber.equals=$text': '';
    List<TokenIssuedModel> list = [];
    dynamic checkResult = await restConnectService.getMethod(
      context, '${Constants.apiTokenIssued}?assignedUid.equals=$agentId$filterStatus$filterReset$filterSearch',
      headers: PrefsUtils.getHeader(prefs));
    final error = ServerErrorModel.fromMap(checkResult);
    if (error.data!=null) return error;
    if (checkResult.isNotEmpty){
      for (var result in checkResult) {
        TokenIssuedModel issued = TokenIssuedModel.fromMap(result);
        list.add(issued);
      }      
      return list;
    }
    return list;
  }

  Future<dynamic> findTokenIssuedByAgentWithStatus(      
      int? agentId,
      List<int>? statues, {bool? reset, int? pageSize, int? page, String? sortBy}) async{
    if (agentId==null || statues==null){
      return null;
    } 
    String filterPage = '';
    if (page!=null && pageSize!=null){
      filterPage = '&page=$page&size=$pageSize&sort=${sortBy??''}';
    }
    String filterStatus = statues.join(',');
    filterStatus = (filterStatus.isNotEmpty)? '&statusCode.in=$filterStatus': '';
    String filterReset = (reset!=null)?'&reset.equals=$reset':'';
    List<TokenIssuedModel> list = [];
    dynamic checkResult = await restConnectService.getMethod(
      context, '${Constants.apiTokenIssued}?assignedUid.equals=$agentId$filterStatus$filterReset$filterPage',
      headers: PrefsUtils.getHeader(prefs));
    final error = ServerErrorModel.fromMap(checkResult);
    if (error.data!=null) return error;
    if (checkResult.isNotEmpty){
      for (var result in checkResult) {
        TokenIssuedModel issued = TokenIssuedModel.fromMap(result);
        list.add(issued);
      }      
      return list;
    }
    return list;
  }

  Future<dynamic> findTokenIssuedByDepartmentWithStatus(      
      int? depId,
      List<int>? statues, {bool? reset, int? pageSize, int? page, String? sortBy}) async{
    if (depId==null || statues==null){
      return null;
    } 
    String filterPage = '';
    if (page!=null && pageSize!=null){
      filterPage = '&page=$page&size=$pageSize&sort=${sortBy??''}';
    }
    String filterStatus = statues.join(',');
    filterStatus = (filterStatus.isNotEmpty)? '&statusCode.in=$filterStatus': '';
    String filterReset = (reset!=null)?'&reset.equals=$reset':'';
    List<TokenIssuedModel> list = [];
    dynamic checkResult = await restConnectService.getMethod(
      context, '${Constants.apiTokenIssued}?departmentId.equals=$depId$filterStatus$filterReset$filterPage',
      headers: PrefsUtils.getHeader(prefs));
    final error = ServerErrorModel.fromMap(checkResult);
    if (error.data!=null) return error;
    if (checkResult.isNotEmpty){
      for (var result in checkResult) {
        TokenIssuedModel issued = TokenIssuedModel.fromMap(result);
        list.add(issued);
      }      
      return list;
    }
    return list;
  }

  Future<dynamic> findTokenIssuedByUidWithStatus(int? uid, List<int>? statues, {bool? reset, int? pageSize, int? page, String? sortBy}) async{
    if (uid==null || statues==null){
      return null;
    } 
    String filterPage = '';
    if (page!=null && pageSize!=null){
      filterPage = '&page=$page&size=$pageSize&sort=${sortBy??''}';
    }
    String filterStatus = statues.join(',');
    filterStatus = (filterStatus.isNotEmpty)? '&statusCode.in=$filterStatus': '';
    String filterReset = (reset!=null)?'&reset.equals=$reset':'';
    List<TokenIssuedModel> list = [];
    dynamic checkResult = await restConnectService.getMethod(
      context, '${Constants.apiTokenIssued}?uid.equals=$uid$filterStatus$filterReset$filterPage',
      headers: PrefsUtils.getHeader(prefs));
    final error = ServerErrorModel.fromMap(checkResult);
    if (error.data!=null) return error;
    if (checkResult.isNotEmpty){
      for (var result in checkResult) {
        TokenIssuedModel issued = TokenIssuedModel.fromMap(result);
        list.add(issued);
      }      
      return list;
    }
    return list;
  }

  Future<dynamic> findTokenIssuedByBizWithStatus(int? bizId, List<int>? statues, {bool? reset, int? pageSize, int? page, String? sortBy}) async{
    if (bizId==null || statues==null){
      return null;
    } 
    String filterPage = '';
    if (page!=null && pageSize!=null){
      filterPage = '&page=$page&size=$pageSize&sort=${sortBy??''}';
    }
    String filterStatus = statues.join(',');
    filterStatus = (filterStatus.isNotEmpty)? '&statusCode.in=$filterStatus': '';
    String filterReset = (reset!=null)?'&reset.equals=$reset':'';
    List<TokenIssuedModel> list = [];
    dynamic checkResult = await restConnectService.getMethod(
      context, '${Constants.apiTokenIssued}?profileBizId.equals=$bizId$filterStatus$filterReset$filterPage',
      headers: PrefsUtils.getHeader(prefs));
    final error = ServerErrorModel.fromMap(checkResult);
    if (error.data!=null) return error;
    if (checkResult.isNotEmpty){
      for (var result in checkResult) {
        TokenIssuedModel issued = TokenIssuedModel.fromMap(result);
        list.add(issued);
      }      
      return list;
    }
    return list;
  }

  Future<int> countTokenIssuedByBizAndDayAndMonthAndYearAndStatus(      
      int? bizId,
      int day,
      int month,
      int year,
      int status, {bool? reset}) async{
    if (bizId==null){
      return 0;
    } 
    String filterStatus = '&statusCode.equals=$status';
    String filterReset = (reset!=null)?'&reset.equals=$reset':'';
    String filterDate = '&modifiedDay.equals=$day&modifiedMonth.equals=$month&modifiedYear.equals=$year';
    int checkResult = await restConnectService.getMethod(
      context, '${Constants.apiTokenIssued}/count?profileBizId.equals=$bizId$filterStatus$filterReset$filterDate',
      headers: PrefsUtils.getHeader(prefs));
    return checkResult;
  }

  Future<int> countTokenIssuedByBizWithStatus(      
      int? bizId,
      List<int>? statues, {bool? reset}) async{
    if (bizId==null || statues==null){
      return 0;
    } 
    String filterStatus = statues.join(',');
    filterStatus = (filterStatus.isNotEmpty)? '&statusCode.in=$filterStatus': '';
    String filterReset = (reset!=null)?'&reset.equals=$reset':'';
    int checkResult = await restConnectService.getMethod(
      context, '${Constants.apiTokenIssued}/count?profileBizId.equals=$bizId$filterStatus$filterReset',
      headers: PrefsUtils.getHeader(prefs));
    return checkResult;
  }

  Future<int> countTokenIssuedByDepartmentWithStatus(      
      int? depId,
      List<int>? statues, {bool? reset}) async{
    if (depId==null || statues==null){
      return 0;
    } 
    String filterStatus = statues.join(',');
    filterStatus = (filterStatus.isNotEmpty)? '&statusCode.in=$filterStatus': '';
    String filterReset = (reset!=null)?'&reset.equals=$reset':'';
    int checkResult = await restConnectService.getMethod(
      context, '${Constants.apiTokenIssued}/count?departmentId.equals=$depId$filterStatus$filterReset',
      headers: PrefsUtils.getHeader(prefs));
    return checkResult;
  }

  Future<int> countTokenIssuedByDepartmentAndTerminalWithStatus(      
      int? depId,
      int? terId,
      List<int>? statues, {bool? reset}) async{
    if (depId==null || statues==null){
      return 0;
    } 
    String filterStatus = statues.join(',');
    filterStatus = (filterStatus.isNotEmpty)? '&statusCode.in=$filterStatus': '';
    String filterReset = (reset!=null)?'&reset.equals=$reset':'';
    int checkResult = await restConnectService.getMethod(
      context, '${Constants.apiTokenIssued}/count?departmentId.equals=$depId&terminalId.equals=$terId$filterStatus$filterReset',
      headers: PrefsUtils.getHeader(prefs));
    return checkResult;
  }

  Future<int> countTokenIssuedByAgentWithStatus(
    int? agentId,
      List<int>? statues, {bool? reset}) async{
    if (agentId==null || statues==null){
      return 0;
    } 
    String filterStatus = statues.join(',');
    filterStatus = (filterStatus.isNotEmpty)? '&statusCode.in=$filterStatus': '';
    String filterReset = (reset!=null)?'&reset.equals=$reset':'';
    int checkResult = await restConnectService.getMethod(
      context, '${Constants.apiTokenIssued}/count?assignedUid.equals=$agentId$filterStatus$filterReset',
      headers: PrefsUtils.getHeader(prefs));
    return checkResult;
  }

  Future<int> countTokenIssuedByDepartment(int? depId, {bool? reset}) async{
    if (depId==null){
      return 0;
    }    
    String filterReset = (reset!=null)?'&reset.equals=$reset':'';
    dynamic checkResult = await restConnectService.getMethod(
      context, '${Constants.apiTokenIssued}/count?queueDepartmentId.equals=$depId$filterReset',
      headers: PrefsUtils.getHeader(prefs));
    return checkResult;
  }

  Future<int> countRatingdByBiz(      
      int? bizId,
      List<int>? ratings, {bool? reset}) async{
    if (bizId==null || ratings==null){
      return 0;
    } 
    String filterRating = ratings.join(',');
    filterRating = (filterRating.isNotEmpty)? '&rating.in=$filterRating': '';
    String filterReset = (reset!=null)?'&reset.equals=$reset':'';
    int checkResult = await restConnectService.getMethod(
      context, '${Constants.apiTokenIssued}/count?profileBizId.equals=$bizId$filterRating$filterReset',
      headers: PrefsUtils.getHeader(prefs));
    return checkResult;
  }

  Future<int> countRatingByBizAndDayAndMonthAndYearAndRating(
      int? bizId,
      int day,
      int month,
      int year,
      int rating, {bool? reset}) async{
    if (bizId==null){
      return 0;
    } 
    String filterRating = '&rating.equals=$rating';
    String filterReset = (reset!=null)?'&reset.equals=$reset':'';
    String filterDate = '&completedDay.equals=$day&completedMonth.equals=$month&completedYear.equals=$year';
    int checkResult = await restConnectService.getMethod(
      context, '${Constants.apiTokenIssued}/count?profileBizId.equals=$bizId$filterRating$filterReset$filterDate',
      headers: PrefsUtils.getHeader(prefs));
    return checkResult;
  }
}