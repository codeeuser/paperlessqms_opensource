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
import 'package:flutter/widgets.dart';

/// A widget that builds its child.
/// The same as [KeyedSubtree]
class KeyedOverlay extends StatelessWidget {
  final Widget child;

  const KeyedOverlay({required Key key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

/// [showOverlay] with block other show with the same [ModalKey].
///
/// for example
/// ```dart
/// final modalKey = ModalKey('simple');
///
/// //popup a simple message on top of screen
/// showSimpleNotification(Text('modal example'), key: modalKey);
///
/// //when previous notification is showing, popup again whit this key
/// //this notification will be rejected.
/// showSimpleNotification(Text('modal example 2'), key: modalKey);
///
/// ```
class ModalKey<T> extends ValueKey<T> {
  const ModalKey(super.value);

  @override
  bool operator ==(other) {
    return other is ModalKey<T> && value == other.value;
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);
}

///
/// The [OverlaySupportEntry] associated with [TransientKey] will be dismiss immediately
/// when next [OverlaySupportEntry] showing by [showOverlay] with the same key.
///
/// This key was designed for [toast], but it seems wired, so have not use yet.
///
/// For example:
/// ```dart
///
/// final key = const TransientKey('transient');
///
/// showSimpleNotification(Text('modal example'), key: key);
///
/// // The previous notification will be dismiss immediately, instead of have
/// // a disappearing animation effect.
/// showSimpleNotification(Text('modal example 2'), key: key);
///
/// ```
class TransientKey<T> extends ValueKey<T> {
  const TransientKey(super.value);

  @override
  bool operator ==(other) {
    return other is TransientKey<T> && value == other.value;
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);
}
