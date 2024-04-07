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
// part of 'overlay.dart';

import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:common/utils/overlay_support/overlay.dart';
import 'package:common/utils/overlay_support/overlay_state_finder.dart';

class AnimatedOverlay extends StatefulWidget {
  /// The total duration of overlay display.
  /// [Duration.zero] means overlay display forever.
  final Duration duration;

  /// The duration overlay show animation.
  final Duration animationDuration;

  /// The duration overlay hide animation.
  final Duration reverseAnimationDuration;

  final AnimatedOverlayWidgetBuilder builder;

  final Curve curve;

  final Key overlayKey;

  final OverlaySupportState overlaySupportState;

  const AnimatedOverlay({
    required Key key,
    required this.animationDuration,
    required this.reverseAnimationDuration,
    Curve? curve,
    required this.builder,
    required this.duration,
    required this.overlayKey,
    required this.overlaySupportState,
  })  : curve = curve ?? Curves.easeInOut,
        assert(animationDuration >= Duration.zero),
        assert(reverseAnimationDuration >= Duration.zero),
        assert(duration >= Duration.zero),
        super(key: key);

  @override
  AnimatedOverlayState createState() => AnimatedOverlayState();
}

class AnimatedOverlayState extends State<AnimatedOverlay>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  CancelableOperation? _autoHideOperation;

  void show() {
    _autoHideOperation?.cancel();
    _controller.forward(from: _controller.value);
  }

  ///
  /// [immediately] True to dismiss notification immediately.
  ///
  Future hide({bool immediately = false}) async {
    if (!immediately &&
        !_controller.isDismissed &&
        _controller.status == AnimationStatus.forward) {
      await _controller.forward(from: _controller.value);
    }
    unawaited(_autoHideOperation?.cancel());
    await _controller.reverse(from: _controller.value);
  }

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: widget.animationDuration,
        reverseDuration: widget.reverseAnimationDuration,
        debugLabel: 'AnimatedOverlayShowHideAnimation');
    super.initState();
    final overlayEntry =
        widget.overlaySupportState.getEntry(key: widget.overlayKey);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        overlayEntry?.dismiss(animate: false);
      } else if (status == AnimationStatus.completed) {
        if (widget.duration > Duration.zero) {
          _autoHideOperation =
              CancelableOperation.fromFuture(Future.delayed(widget.duration))
                ..value.whenComplete(() {
                  hide();
                });
        }
      }
    });
    show();
  }

  @override
  void dispose() {
    _controller.dispose();
    _autoHideOperation?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return widget.builder(
              context, widget.curve.transform(_controller.value));
        });
  }
}
