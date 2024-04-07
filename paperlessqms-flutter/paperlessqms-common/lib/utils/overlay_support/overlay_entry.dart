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

import 'package:flutter/material.dart';
import 'package:common/utils/overlay_support/overlay_animation.dart';
import 'package:common/utils/overlay_support/overlay_state_finder.dart';


abstract class OverlaySupportEntry {
  factory OverlaySupportEntry.internal(
    OverlayEntry entry,
    Key key,
    GlobalKey<AnimatedOverlayState> stateKey,
    OverlaySupportState overlaySupport,
  ) {
    return _OverlaySupportEntryImpl._(entry, key, stateKey, overlaySupport);
  }

  factory OverlaySupportEntry.empty() {
    return _OverlaySupportEntryEmpty();
  }

  /// Find OverlaySupportEntry by [context].
  ///
  /// The [context] should be the BuildContext which build a element in Notification.
  ///
  static OverlaySupportEntry? of(BuildContext context) {
    final animatedOverlay =
        context.findAncestorWidgetOfExactType<AnimatedOverlay>();
    assert(() {
      if (animatedOverlay == null) {
        throw FlutterError('No KeyedOverlay widget found.\n'
            'The [context] should be the BuildContext which build a element in Notification.\n'
            'is that you called this method from the right scope? ');
      }
      return true;
    }());
    if (animatedOverlay == null) {
      return OverlaySupportEntry.empty();
    }
    return animatedOverlay.overlaySupportState
        .getEntry(key: animatedOverlay.overlayKey);
  }

  /// Dismiss the Overlay which associated with this entry.
  /// If [animate] is false, remove entry immediately.
  /// If [animate] is true, remove entry after [AnimatedOverlayState.hide]
  void dismiss({bool animate = true});

  Future get dismissed;
}

/// [OverlaySupportEntry] represent a overlay popup by [showOverlay].
///
/// Provide function [dismiss] to dismiss a Notification/Overlay.
///
class _OverlaySupportEntryImpl implements OverlaySupportEntry {
  final OverlayEntry _entry;
  final Key _overlayKey;
  final GlobalKey<AnimatedOverlayState> _stateKey;
  final OverlaySupportState _overlaySupport;

  _OverlaySupportEntryImpl._(
    this._entry,
    this._overlayKey,
    this._stateKey,
    this._overlaySupport,
  );

  // To known when notification has been dismissed.
  final Completer _dismissedCompleter = Completer();

  @override
  Future get dismissed => _dismissedCompleter.future;

  // OverlayEntry has been scheduled to dismiss,
  // indicate OverlayEntry is hiding or already remove from Overlay
  bool _dismissScheduled = false;

  // OverlayEntry has been removed from Overlay
  bool _dismissed = false;

  @override
  void dismiss({bool animate = true}) {
    if (_dismissed || (_dismissScheduled && animate)) {
      return;
    }
    if (!_dismissScheduled) {
      // Remove this entry from overlaySupportState no matter it is animating or not.
      // because when the entry with the same key, we need to show it now.
      _overlaySupport.removeEntry(key: _overlayKey);
    }
    _dismissScheduled = true;

    if (!animate) {
      _dismissEntry();
      return;
    }

    void animateRemove() {
      if (_stateKey.currentState != null) {
        _stateKey.currentState!.hide().whenComplete(() {
          _dismissEntry();
        });
      } else {
        //we need show animation before remove this entry
        //so need ensure entry has been inserted into screen
        _ambiguate(WidgetsBinding.instance)
            ?.scheduleFrameCallback((_) => animateRemove());
      }
    }

    animateRemove();
  }

  // dismiss entry immediately and remove it from screen
  void _dismissEntry() {
    if (_dismissed) {
      // already removed from screen
      return;
    }
    _dismissed = true;
    _entry.remove();
    _dismissedCompleter.complete();
  }
}

/// This allows a value of type T or T?
/// to be treated as a value of type T?.
///
/// We use this so that APIs that have become
/// non-nullable can still be used with `!` and `?`
/// to support older versions of the API as well.
T? _ambiguate<T>(T? value) => value;

class _OverlaySupportEntryEmpty implements OverlaySupportEntry {
  @override
  void dismiss({bool animate = true}) {}

  @override
  Future get dismissed => Future.value(null);
}
