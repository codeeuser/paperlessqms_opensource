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
import 'package:common/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:common/models/header_model.dart';
import 'package:common/services/dio_logger.dart';

class BaseService extends Object {
  static const String tag = 'BaseService';

  Dio? _dio;
  void createClient(BuildContext context) {
    _dio ??= Dio(BaseOptions())..interceptors.add(DioLogger(
        context: context,
        logPrint: Logger.logDio,
      ));
    Logger.log(tag, message: 'Dio createClient...dio: ${_dio.hashCode}');  
  }

  void close() {
    Logger.log(tag, message: 'Dio close...');
    _dio?.close();
    _dio = null;
  }

  Future<dynamic> getMethod(
    BuildContext context,
      String url, {String? responseFormat, List<HeaderModel>? headers}) async {
    ResponseType responseType = (responseFormat?.toLowerCase()=='csv')?ResponseType.plain: ResponseType.json;
        
    try {
      createClient(context);
      Response? response = await _dio?.get(url,
          options: Options(
            responseType: responseType,
            headers: _createHeader(headers),
          )); 
      int? code = response?.statusCode;    
      if (code!=null && code >= 200 && code < 300) {
        return response?.data;
      }
      return Future.value(null);
    } on DioException catch (e) {
      int? code = e.response?.statusCode;
      Logger.log(tag, message: '$code: $url $e');
      List<String> errorArr = '$e'.split(':');
      String error = (errorArr.isNotEmpty)? errorArr.last: e.toString();
      var data = e.response?.data;
      data = (data=='')? {}: data;
      final result = {
        'status': code,
        'limit': true,
        'error': error,
        'data': data,
      };
      Logger.log(tag, message: 'REST getMethod: $result');
      return Future.value(result);
    }
  }

  Future<dynamic> postMethod(BuildContext context, String url, 
      {String? responseFormat, List<HeaderModel>? headers, String? body}) async {
    
    createClient(context);
    ResponseType responseType = (responseFormat?.toLowerCase()=='csv')?ResponseType.plain: ResponseType.json;
    
    String data = body?.trim() ?? '';
    try {
      Response? response;
      response = await _dio?.post(url,
        data: (data.isEmpty==true)? null: data,
        options: Options(
          contentType: Headers.jsonContentType,
          responseType: responseType,
          headers: _createHeader(headers),
        ));
      
      int? code = response?.statusCode;    
      if (code!=null && code >= 200 && code < 300) {
        return response?.data;
      }
      return Future.value(null);
    } on DioException catch (e, s) {
      int? code = e.response?.statusCode;
      dynamic data = e.response?.data;
      Logger.log(tag, message: '$code: $url $e $s');
      List<String> errorArr = '$e'.split(':');
      String error = (errorArr.isNotEmpty)? errorArr.last: e.toString();
      data = (data=='')? {}: data;
      final result = {
        'status': code,
        'limit': true,
        'error': error,
        'data': data,
      };
      return Future.value(result);
    }
  }

  Future<dynamic> putMethod(BuildContext context, String url, 
      {String? responseFormat, List<HeaderModel>? headers, String? body, Map<String, dynamic>? queryParameters}) async {
    
    createClient(context);
    ResponseType responseType = (responseFormat?.toLowerCase()=='csv')?ResponseType.plain: ResponseType.json;
    
    String data = body?.trim() ?? '';
    try {
      Response? response;
      response = await _dio?.put(url,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          contentType: Headers.jsonContentType,
          responseType: responseType,
          headers: _createHeader(headers),
      ));
      int? code = response?.statusCode;    
      if (code!=null && code >= 200 && code < 300) {
        return response?.data;
      }
      return Future.value(null);
    } on DioException catch (e) {
      int? code = e.response?.statusCode;
      Logger.log(tag, message: '$code: $url $e');
      List<String> errorArr = '$e'.split(':');
      String error = (errorArr.isNotEmpty)? errorArr.last: e.toString();
      var data = e.response?.data;
      data = (data=='')? {}: data;
      final result = {
        'status': code,
        'limit': true,
        'error': error,
        'data': data,
      };
      return Future.value(result);
    }
  }

  Future<dynamic> patchMethod(BuildContext context, String url, 
      {String? responseFormat, List<HeaderModel>? headers, String? body, Map<String, dynamic>? queryParameters}) async {
    
    createClient(context);
    ResponseType responseType = (responseFormat?.toLowerCase()=='csv')?ResponseType.plain: ResponseType.json;
    
    String data = body?.trim() ?? '';
    try {
      Response? response;
      response = await _dio?.patch(url,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          contentType: Headers.jsonContentType,
          responseType: responseType,
          headers: _createHeader(headers),
      ));
      int? code = response?.statusCode;    
      if (code!=null && code >= 200 && code < 300) {
        return response?.data;
      }
      return Future.value(null);
    } on DioException catch (e) {
      int? code = e.response?.statusCode;
      Logger.log(tag, message: '$code: $url $e');
      List<String> errorArr = '$e'.split(':');
      String error = (errorArr.isNotEmpty)? errorArr.last: e.toString();
      var data = e.response?.data;
      data = (data=='')? {}: data;
      final result = {
        'status': code,
        'limit': true,
        'error': error,
        'data': data,
      };
      return Future.value(result);
    }
  }

  Future<dynamic> deleteMethod(BuildContext context, String url, 
      {String? responseFormat, List<HeaderModel>? headers, String? body, Map<String, dynamic>? queryParameters}) async {
    
    createClient(context);
    ResponseType responseType = (responseFormat?.toLowerCase()=='csv')?ResponseType.plain: ResponseType.json;
    
    String data = body?.trim() ?? '';
    try {
      Response? response;
      response = await _dio?.delete(url,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          contentType: Headers.jsonContentType,
          responseType: responseType,
          headers: _createHeader(headers),
      ));
      int? code = response?.statusCode;    
      if (code!=null && code >= 200 && code < 300) {
        return response?.data;
      }
      return Future.value(null);
    } on DioException catch (e) {
      int? code = e.response?.statusCode;
      Logger.log(tag, message: '$code: $url $e');
      List<String> errorArr = '$e'.split(':');
      String error = (errorArr.isNotEmpty)? errorArr.last: e.toString();
      var data = e.response?.data;
      data = (data=='')? {}: data;
      final result = {
        'status': code,
        'limit': true,
        'error': error,
        'data': data,
      };
      return Future.value(result);
    }
  }

  Map<String, dynamic> _createHeader(List<HeaderModel>? headers){
    Map<String, dynamic> mapHeader = {};
    for (HeaderModel header in headers ?? []) {
      mapHeader[header.name] = header.value;
    }
    return mapHeader;
  }
}
