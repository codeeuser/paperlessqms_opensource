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
import 'package:flutter/material.dart';
import 'package:common/utils/overlay_support.dart';
import 'package:common/utils/overlay_support/notification/notification.dart';
import 'package:common/utils/overlay_support/overlay.dart';
import 'package:common/utils/overlay_support/overlay_entry.dart';

/// Popup a notification at the top of screen.
///
/// [duration] the notification display duration , overlay will auto dismiss after [duration].
/// if null , will be set to [kNotificationDuration].
/// if zero , will not auto dismiss in the future.
///
/// [animationDuration] the notification display animation duration..
/// if null , will be set to [kNotificationSlideDuration].
/// if zero , will display immediately.
///
/// [reverseAnimationDuration] the notification hide animation duration..
/// if null , will be set to [kNotificationSlideDuration].
/// if zero , will hide immediately.
///
/// [position] the position of notification, default is [NotificationPosition.top],
/// can be [NotificationPosition.top] or [NotificationPosition.bottom].
///
OverlaySupportEntry showOverlayNotification(
  WidgetBuilder builder, {
  Duration? duration,
  Duration? animationDuration,
  Duration? reverseAnimationDuration,
  Key? key,
  NotificationPosition position = NotificationPosition.top,
  BuildContext? context,
}) {
  duration ??= kNotificationDuration;
  animationDuration ??= kNotificationSlideDuration;
  reverseAnimationDuration ??= kNotificationSlideDuration;
  return showOverlay(
    (context, t) {
      var alignment = MainAxisAlignment.start;
      if (position == NotificationPosition.bottom) {
        alignment = MainAxisAlignment.end;
      }
      return Column(
        mainAxisAlignment: alignment,
        children: <Widget>[
          position == NotificationPosition.top
              ? TopSlideNotification(builder: builder, progress: t)
              : BottomSlideNotification(builder: builder, progress: t)
        ],
      );
    },
    duration: duration,
    animationDuration: animationDuration,
    reverseAnimationDuration: reverseAnimationDuration,
    key: key,
    context: context,
  );
}

///
/// Show a simple notification above the top of window.
///
OverlaySupportEntry showSimpleNotification(
  Widget content, {
  /**
   * See more [ListTile.leading].
   */
  Widget? leading,
  /**
   * See more [ListTile.subtitle].
   */
  Widget? subtitle,
  /**
   * See more [ListTile.trailing].
   */
  Widget? trailing,
  /**
   * See more [ListTile.contentPadding].
   */
  EdgeInsetsGeometry? contentPadding,
  /**
   * The background color for notification, default to [ColorScheme.secondary].
   */
  Color? background,
  /**
   * See more [ListTileTheme.textColor],[ListTileTheme.iconColor].
   */
  Color? foreground,
  /**
   * The elevation of notification, see more [Material.elevation].
   */
  double elevation = 16,
  Duration? duration,
  Duration? animationDuration,
  Duration? reverseAnimationDuration,
  Key? key,
  /**
   * True to auto hide after duration [kNotificationDuration].
   */
  bool autoDismiss = true,
  /**
   * Support left/right to dismiss notification.
   */
  @Deprecated('use slideDismissDirection instead') bool slideDismiss = false,
  /**
   * The position of notification, default is [NotificationPosition.top],
   */
  NotificationPosition position = NotificationPosition.top,
  BuildContext? context,
  /**
   * The direction in which the notification can be dismissed.
   */
  DismissDirection? slideDismissDirection,
}) {
  final dismissDirection = slideDismissDirection ??
      (slideDismiss ? DismissDirection.horizontal : DismissDirection.none);
  final entry = showOverlayNotification(
    (context) {
      return SlideDismissible(
        direction: dismissDirection,
        key: ValueKey(key),
        child: Material(
          color: background ?? Theme.of(context).colorScheme.secondary,
          elevation: elevation,
          child: SafeArea(
              bottom: position == NotificationPosition.bottom,
              top: position == NotificationPosition.top,
              child: ListTileTheme(
                textColor:
                    foreground ?? Theme.of(context).colorScheme.onSecondary,
                iconColor:
                    foreground ?? Theme.of(context).colorScheme.onSecondary,
                child: ListTile(
                  leading: leading,
                  title: content,
                  subtitle: subtitle,
                  trailing: trailing,
                  contentPadding: contentPadding,
                ),
              )),
        ),
      );
    },
    duration: autoDismiss ? duration : Duration.zero,
    animationDuration: animationDuration,
    reverseAnimationDuration: reverseAnimationDuration,
    key: key,
    position: position,
    context: context,
  );
  return entry;
}
