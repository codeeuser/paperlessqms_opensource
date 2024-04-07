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
import 'package:common/models/queue_department_model.dart';
import 'package:common/models/queue_service_model.dart';
import 'package:common/models/server_error_model.dart';
import 'package:common/services/rest_connect_service.dart';
import 'package:common/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceRepository {
  final SharedPreferences prefs;
  final BuildContext context;
  const ServiceRepository({required this.context, required this.prefs});

  static RestConnectService restConnectService = locator<RestConnectService>();

  Future<dynamic> findServiceByDepartment(
        QueueDepartmentModel? dep, {bool? enable}) async{
    if (dep==null || dep.id==null) return null;
    String filter = (enable!=null)?'&enable.equals=$enable':'';
    dynamic result = await restConnectService.getMethod(
      context, 
      '${Constants.apiService}?queueDepartmentId.equals=${dep.id}$filter',
      headers: PrefsUtils.getHeader(prefs),
    );
    final error = ServerErrorModel.fromMap(result);
    if (error.data!=null) return error;
    List<QueueServiceModel> list = [];
    for (Map e in result) {
      list.add(QueueServiceModel.fromMap(e));
    }
    return list;
  }

  Future<dynamic> saveService(QueueServiceModel? service) async{
    if (service==null) return null;
    final result = await restConnectService.postMethod(
      context, 
      Constants.apiService,
      headers: PrefsUtils.getHeader(prefs),
      body: jsonEncode(service.toJson())
    );
    final error = ServerErrorModel.fromMap(result);
    if (error.data!=null) return error;
    return QueueServiceModel.fromMap(result);
  }

  Future<dynamic> updateService(QueueServiceModel? service) async{
    if (service==null) return null;
    final result = await restConnectService.putMethod(
      context, 
      '${Constants.apiService}/${service.id}',
      headers: PrefsUtils.getHeader(prefs),
      body: jsonEncode(service.toJson())
    );
    final error = ServerErrorModel.fromMap(result);
    if (error.data!=null) return error;
    return QueueServiceModel.fromMap(result);
  }

  Future<dynamic> deleteService(QueueServiceModel? service) async{
    if (service==null) return null;
    dynamic result = await restConnectService.deleteMethod(
      context, 
      '${Constants.apiService}/${service.id}',
      headers: PrefsUtils.getHeader(prefs),
    );
    final error = ServerErrorModel.fromMap(result);
    if (error.data!=null) return error;
    return (result is String)? result: null;
  }
}