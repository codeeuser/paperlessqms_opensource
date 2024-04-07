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
import 'package:common/models/account_model.dart';
import 'package:common/models/profile_biz_model.dart';
import 'package:common/models/server_error_model.dart';
import 'package:common/services/rest_connect_service.dart';
import 'package:common/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BizRepository {
  final SharedPreferences prefs;
  final BuildContext context;
  const BizRepository({required this.context, required this.prefs});

  static RestConnectService restConnectService = locator<RestConnectService>();

  Future<dynamic> getProfileBiz() async{
    AccountModel? account = PrefsUtils.getAccount(prefs);
    if (account==null) return null;
    
    dynamic checkResult = await restConnectService.getMethod(
      context, '${Constants.apiBusiness}?createdByUid.equals=${account.id}',
      headers: PrefsUtils.getHeader(prefs));
    final error = ServerErrorModel.fromMap(checkResult);
    if (error.data!=null) return error;
    if (checkResult is List && checkResult.isNotEmpty){
      ProfileBizModel profileBiz = ProfileBizModel.fromMap(checkResult.last);
      return profileBiz;
    }
    return null;
  }

  Future<dynamic> findProfileBizById(int? profileBizId) async{
    if (profileBizId==null) return null;
    dynamic result = await restConnectService.getMethod(context, '${Constants.apiBusiness}/$profileBizId', headers: PrefsUtils.getHeader(prefs));
    final error = ServerErrorModel.fromMap(result);
    if (error.data!=null) return error;
    if (result!=null){
      ProfileBizModel biz = ProfileBizModel.fromMap(result);
      return biz;
    }
    return null;
  }

  Future<dynamic> search(String? value, bool enable) async{
    if (value==null) return null;
    String filter = 'bizName.contains=$value&enable.equals=$enable';
    dynamic checkResult = await restConnectService.getMethod(
      context, '${Constants.apiBusiness}?$filter',
      headers: PrefsUtils.getHeader(prefs));
    final error = ServerErrorModel.fromMap(checkResult);
    if (error.data!=null) return error;
    if (checkResult.isNotEmpty){
      List<ProfileBizModel> list = [];
      for (Map e in checkResult) {
        ProfileBizModel biz = ProfileBizModel.fromMap(e);
        list.add(biz);
      }      
      return list;
    }
    return null;
  }

  Future<dynamic> getBusinessList({bool? enable, int? pageSize, int? page, String? sortBy}) async{
    String filterPage = '';
    if (page!=null && pageSize!=null){
      filterPage = 'page=$page&size=$pageSize&sort=${sortBy??''}';
    }
    String filterEnable = (enable!=null)?'&enable.equals=$enable':'';
    dynamic checkResult = await restConnectService.getMethod(
      context, '${Constants.apiBusiness}?$filterPage$filterEnable',
      headers: PrefsUtils.getHeader(prefs));
    final error = ServerErrorModel.fromMap(checkResult);
    if (error.data!=null) return error;
    List<ProfileBizModel> list = [];
    if (checkResult.isNotEmpty){
      for (Map<String, dynamic> e in checkResult) {
        ProfileBizModel biz = ProfileBizModel.fromMap(e);
        list.add(biz);
      } 
    }
    return list;
  }

  Future<dynamic> saveBusiness(ProfileBizModel? biz) async{
    if (biz==null) return null;
    final result = await restConnectService.postMethod(
      context, 
      Constants.apiBusiness,
      headers: PrefsUtils.getHeader(prefs),
      body: jsonEncode(biz.toJson())
    );
    final error = ServerErrorModel.fromMap(result);
    if (error.data!=null) return error;
    return ProfileBizModel.fromMap(result);
  }

  Future<dynamic> updateBusiness(ProfileBizModel? biz) async{
    if (biz==null) return null;
    final result = await restConnectService.putMethod(
      context, 
      '${Constants.apiBusiness}/${biz.id}',
      headers: PrefsUtils.getHeader(prefs),
      body: jsonEncode(biz.toJson())
    );
    final error = ServerErrorModel.fromMap(result);
    if (error.data!=null) return error;
    return ProfileBizModel.fromMap(result);
  }

  Future<dynamic> deleteBiz(ProfileBizModel? biz) async{
    if (biz==null || biz.id==null) return null;
    dynamic result = await restConnectService.deleteMethod(
      context, 
      '${Constants.apiBusiness}/${biz.id}',
      headers: PrefsUtils.getHeader(prefs),
    );
    final error = ServerErrorModel.fromMap(result);
    if (error.data!=null) return error;
    return result;
  }
}