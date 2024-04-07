// ignore_for_file: use_build_context_synchronously

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

import 'dart:io';

import 'package:client/logger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AppConstants{
  static const String appTitle = 'Client App';
  static const String appPrefix = 'vpaper_client_';
}

class AppUtils{
  static const String tag = 'AppUtils';

  static Future<bool?> requestPermissions(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    if (Platform.isIOS) {
      return await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isMacOS) {
      return await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

      final bool? grantedNotificationPermission =
          await androidImplementation?.requestNotificationsPermission();
      // setState(() {
      //   _notificationsEnabled = grantedNotificationPermission ?? false;
      // });
      return grantedNotificationPermission ?? false;
    }
    return false;
  }

  static Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin, 
      int id,
      String title,
      String body) async {
    Logger.log(tag, message: 'showNotification---, body: $body');

    const String darwinNotificationCategoryPlain = 'plainCategory';
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        'your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    const DarwinNotificationDetails iosNotificationDetails = DarwinNotificationDetails(
      categoryIdentifier: darwinNotificationCategoryPlain,
    );

    // const DarwinNotificationDetails macOSNotificationDetails = DarwinNotificationDetails(
    //   categoryIdentifier: darwinNotificationCategoryPlain,
    // );

    // const LinuxNotificationDetails linuxNotificationDetails = LinuxNotificationDetails(
    //   actions: <LinuxNotificationAction>[
    //     LinuxNotificationAction(
    //       key: urlLaunchActionId,
    //       label: 'Action 1',
    //     ),
    //     LinuxNotificationAction(
    //       key: navigationActionId,
    //       label: 'Action 2',
    //     ),
    //   ],
    // );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
      // macOS: macOSNotificationDetails,
      // linux: linuxNotificationDetails,
    );
    await flutterLocalNotificationsPlugin
        .show(id++, title, body, notificationDetails, payload: 'item z');
  }
}
