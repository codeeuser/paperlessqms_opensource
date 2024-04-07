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
import 'package:catcher_2/catcher_2.dart';
import 'package:common/app_log.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Logger {
  static const bool b = false;
  static void log(String? tag, {required String? message}) {
    assert(tag != null);

    if (kReleaseMode == b) {
      final f = DateFormat('HH:mm:S');
      String s = f.format(DateTime.now());
      // ignore: avoid_print
      print("[$tag][$s] $message");
    }
  }

  static void logDio(BuildContext context, String obj) {
    if (kReleaseMode == b) {
      final f = DateFormat('HH:mm:S');
      String s = f.format(DateTime.now());
      // ignore: avoid_print
      print("['DIOLOG'][$s] $obj");
    } 
    obj = obj.replaceAll('=', '');
    obj = obj.replaceAll('onResponse', '');
    obj = obj.replaceAll('BEGIN', '');
    obj = obj.replaceAll('END', '');
    if (obj.isNotEmpty){
      obj = obj.replaceAll('\n', '');
      obj += '\n';
    }
    AppLog appLog = context.read<AppLog>();
    appLog.logDioMessage = obj;
  }

  static sendCatcherError(tag, e, s) {
    final f = DateFormat('HH:mm:S');
    String time = f.format(DateTime.now());
    Catcher2.reportCheckedError('[$tag][$time] $e', s);
    if (kReleaseMode == b) {
      // ignore: avoid_print
      print("[$tag][$time] $e");
    }
  }
}
