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
import 'package:flutter/widgets.dart';
import 'package:common/utils/functions.dart';
import 'package:common/utils/overlay_support/overlay_entry.dart';

/// A notification show in front of screen and shown at the top.
class TopSlideNotification extends StatelessWidget {
  /// Which used to build notification content.
  final WidgetBuilder builder;

  final double progress;

  const TopSlideNotification(
      {super.key, required this.builder, required this.progress});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: SizedBox(
        width: (Utils.isPhoneSize(context)==true)? MediaQuery.of(context).size.width: 400,
        child: FractionalTranslation(
          translation:
              Offset.lerp(const Offset(0, -1), const Offset(0, 0), progress)!,
          child: Center(child: builder(context)),
        ),
      ),
    );
  }
}

/// a notification show in front of screen and shown at the bottom
class BottomSlideNotification extends StatelessWidget {
  ///build notification content
  final WidgetBuilder builder;

  final double progress;

  const BottomSlideNotification(
      {super.key, required this.builder, required this.progress});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: SizedBox(
        width: (Utils.isPhoneSize(context)==true)? MediaQuery.of(context).size.width: 400,
        child: FractionalTranslation(
          translation:
              Offset.lerp(const Offset(0, 1), const Offset(0, 0), progress)!,
          child: Center(child: builder(context)),
        ),
      ),
    );
  }
}

/// Can be dismiss by left or right slide.
class SlideDismissible extends StatelessWidget {
  final Widget child;

  final DismissDirection direction;

  const SlideDismissible({
    super.key,
    required this.child,
    @Deprecated('use directions instead.') bool enable = true,
    DismissDirection? direction,
  })  : direction = direction ??
            (enable ? DismissDirection.horizontal : DismissDirection.none);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: key!,
      direction: direction,
      onDismissed: (direction) {
        OverlaySupportEntry.of(context)!.dismiss(animate: false);
      },
      child: child,
    );
  }
}

/// Indicates if notification is going to show at the [top] or at the [bottom].
enum NotificationPosition { top, bottom }
