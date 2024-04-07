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

/// Theme data for toast.
class ToastThemeData {
  final Color textColor;

  final Color background;

  final Alignment alignment;

  const ToastThemeData.raw({
    required this.textColor,
    required this.background,
    required this.alignment,
  });

  factory ToastThemeData({
    Color? textColor,
    Color? background,
    Alignment? alignment,
  }) {
    return ToastThemeData.raw(
        textColor: textColor ?? Colors.black87,
        background: background ?? const Color(0xfceeeeee),
        alignment: alignment ?? const Alignment(0, 0.618));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToastThemeData &&
          runtimeType == other.runtimeType &&
          textColor == other.textColor &&
          background == other.background &&
          alignment == other.alignment;

  @override
  int get hashCode =>
      textColor.hashCode ^ background.hashCode ^ alignment.hashCode;
}

class OverlaySupportTheme extends InheritedWidget {
  final ToastThemeData toastTheme;

  const OverlaySupportTheme({
    super.key,
    required super.child,
    required this.toastTheme,
  });

  static OverlaySupportTheme? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<OverlaySupportTheme>();
  }

  static ToastThemeData? toast(BuildContext context) {
    return of(context)?.toastTheme;
  }

  @override
  bool updateShouldNotify(OverlaySupportTheme oldWidget) {
    return toastTheme != oldWidget.toastTheme;
  }
}
