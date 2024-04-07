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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:common/utils/overlay_support.dart';
import 'package:common/utils/overlay_support/overlay_animation.dart';
import 'package:common/utils/overlay_support/overlay_entry.dart';

import 'overlay_keys.dart';
import 'overlay_state_finder.dart';

// part 'overlay_animation.dart';

// part 'overlay_entry.dart';

/// To build a widget with animated value.
/// [progress] : the progress of overlay animation from 0 - 1
///
/// A simple use case is [TopSlideNotification] in [showOverlayNotification].
///
typedef AnimatedOverlayWidgetBuilder = Widget Function(
    BuildContext context, double progress);

/// Basic api to show overlay widget.
///
/// [duration] : the overlay display duration , overlay will auto dismiss after [duration].
/// if null , will be set to [kNotificationDuration].
/// if zero , will not auto dismiss in the future.
///
/// [builder] : see [AnimatedOverlayWidgetBuilder].
///
/// [curve] : adjust the rate of change of an animation.
///
/// [key] : to identify a OverlayEntry.
///
/// for example:
/// ```dart
/// final key = ValueKey('my overlay');
///
/// // step 1: popup a overlay
/// showOverlay(builder, key: key);
///
/// // step 2: popup a overlay use the same key
/// showOverlay(builder2, key: key);
/// ```
///
/// If the notification1 of step1 is showing, the step2 will dismiss previous notification1.
///
/// If you want notification1' exist to prevent step2, please see [ModalKey]
///
///
OverlaySupportEntry showOverlay(
  AnimatedOverlayWidgetBuilder builder, {
  Curve? curve,
  Duration? duration,
  Key? key,
  BuildContext? context,
  Duration? animationDuration,
  Duration? reverseAnimationDuration,
}) {
  assert(key is! GlobalKey);

  final overlaySupport = findOverlayState(context: context);
  final overlay = overlaySupport?.overlayState;
  if (overlaySupport == null || overlay == null) {
    assert(() {
      debugPrint('overlay not available, dispose this call : $key');
      return true;
    }());
    return OverlaySupportEntry.empty();
  }

  final overlayKey = key ?? UniqueKey();

  final oldSupportEntry = overlaySupport.getEntry(key: overlayKey);
  if (oldSupportEntry != null && key is ModalKey) {
    // Do nothing for modal key if there be a OverlayEntry hold the same model key
    // and it is showing.
    return oldSupportEntry;
  }

  final dismissImmediately = key is TransientKey;
  // If we got a showing overlaySupport with [key], we should dismiss it before showing a new.
  oldSupportEntry?.dismiss(animate: !dismissImmediately);

  final stateKey = GlobalKey<AnimatedOverlayState>();
  final entry = OverlayEntry(builder: (context) {
    return KeyedOverlay(
      key: overlayKey,
      child: AnimatedOverlay(
        key: stateKey,
        builder: builder,
        curve: curve,
        animationDuration: animationDuration ?? kNotificationSlideDuration,
        reverseAnimationDuration:
            reverseAnimationDuration ?? kNotificationSlideDuration,
        duration: duration ?? kNotificationDuration,
        overlayKey: overlayKey,
        overlaySupportState: overlaySupport,
      ),
    );
  });
  final supportEntry = OverlaySupportEntry.internal(
      entry, overlayKey, stateKey, overlaySupport);
  overlaySupport.addEntry(supportEntry, key: overlayKey);
  overlay.insert(entry);
  return supportEntry;
}
