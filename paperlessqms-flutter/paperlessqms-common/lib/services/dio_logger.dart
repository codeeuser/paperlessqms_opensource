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
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DioLogger extends Interceptor {

  final BuildContext context;

  /// Print error message
  final bool error;

  /// Log printer; defaults logPrint log to console.
  /// you can also write log in a file.
  final void Function(BuildContext context, String msg) logPrint;


  DioLogger({
    required this.context,
    this.error = true,
    required this.logPrint,
  });

  late DateTime _startTime;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    try {
      _logOnRequest(options);
    } catch (e) {
      logPrint(context, 'ErrorLogger: $e');
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    try {
      _logOnError(err);
    } catch (e) {
      logPrint(context, 'ErrorLogger: $e');
    }
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    try {
      _logOnResponse(response);
    } catch (e) {
      logPrint(context, 'ErrorLogger: $e');
    }
    super.onResponse(response, handler);
  }

  void _logOnRequest(RequestOptions options) {
    _startTime = DateTime.now();
    // final uri = options.uri;
    // final method = options.method;

    // logPrint(context, 'Request | $method | Uri | ${uri.toString()}');    
  }

  void _logOnError(DioException err) {
    String text = '';
    if (error) {
      final uri = err.requestOptions.uri;
      text = 'Error | Status: ${err.response?.statusCode} ${err.response?.statusMessage} | Uri | ${uri.toString()}';
      _logProcessingTime(text);
    }
  }

  void _logOnResponse(Response response) {
    final uri = response.requestOptions.uri;
    final method = response.requestOptions.method;
    final f = DateFormat('HH:mm:s S');
    String s = f.format(_startTime);

    String text = '[$s] Response | $method | Status: ${response.statusCode} ${response.statusMessage} | Uri | ${uri.toString()}';
    
    _logProcessingTime(text);
  }

  void _logProcessingTime(String text) {
    logPrint(context, '$text | Processing Time: ${DateTime.now().difference(_startTime).inMilliseconds.toString()} ms');
  }
}
