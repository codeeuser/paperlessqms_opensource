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
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:common/utils/overlay_support/overlay_entry.dart';
import 'package:common/utils/overlay_support/theme.dart';

final GlobalKey<OverlaySupportState> _keyFinder =
    GlobalKey(debugLabel: 'overlay_support');

OverlaySupportState? findOverlayState({BuildContext? context}) {
  if (context == null) {
    assert(
      _debugInitialized,
      'Global OverlaySupport Not Initialized ! \n'
      'ensure your app wrapped widget OverlaySupport.global',
    );
    final state = _keyFinder.currentState;
    assert(() {
      if (state == null) {
        throw FlutterError('''we can not find OverlaySupportState in your app.
         
         do you declare OverlaySupport.global you app widget tree like this?
         
         OverlaySupport.global(
           child: MaterialApp(
             title: 'Overlay Support Example',
             home: HomePage(),
           ),
         )
      
      ''');
      }
      return true;
    }());
    return state;
  }
  final overlaySupportState =
      context.findAncestorStateOfType<OverlaySupportState>();
  return overlaySupportState;
}

bool _debugInitialized = false;

class OverlaySupport extends StatelessWidget {
  final Widget child;

  final ToastThemeData? toastTheme;

  final bool global;

  const OverlaySupport({
    super.key,
    required this.child,
    this.toastTheme,
    this.global = true,
  });

  const OverlaySupport.global({super.key, 
    required this.child,
    this.toastTheme,
  }) : global = true;

  const OverlaySupport.local({super.key,
    required this.child,
    this.toastTheme,
  }) : global = false;

  OverlaySupportState? of(BuildContext context) {
    return context.findAncestorStateOfType<OverlaySupportState>();
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupportTheme(
      toastTheme:
          toastTheme ?? OverlaySupportTheme.toast(context) ?? ToastThemeData(),
      child: global
          ? _GlobalOverlaySupport(child: child)
          : _LocalOverlaySupport(child: child),
    );
  }
}

class _GlobalOverlaySupport extends StatefulWidget {
  final Widget child;

  _GlobalOverlaySupport({required this.child}) : super(key: _keyFinder);

  @override
  StatefulElement createElement() {
    _debugInitialized = true;
    return super.createElement();
  }

  @override
  _GlobalOverlaySupportState createState() => _GlobalOverlaySupportState();
}

class _GlobalOverlaySupportState
    extends OverlaySupportState<_GlobalOverlaySupport> {
  @override
  Widget build(BuildContext context) {
    assert(() {
      if (context.findAncestorWidgetOfExactType<_GlobalOverlaySupport>() !=
          null) {
        throw FlutterError(
            'There is already an OverlaySupport.global in the Widget tree.');
      }
      return true;
    }());
    return widget.child;
  }

  @override
  OverlayState? get overlayState {
    NavigatorState? navigator;
    void visitor(Element element) {
      if (navigator != null) return;

      if (element.widget is Navigator) {
        navigator = (element as StatefulElement).state as NavigatorState?;
      } else {
        element.visitChildElements(visitor);
      }
    }

    context.visitChildElements(visitor);

    assert(navigator != null,
        '''It looks like you are not using Navigator in your app.
         
         do you wrapped you app widget like this?
         
         OverlaySupport(
           child: MaterialApp(
             title: 'Overlay Support Example',
             home: HomePage(),
           ),
         )
      
      ''');
    return navigator?.overlay;
  }
}

class _LocalOverlaySupport extends StatefulWidget {
  final Widget child;

  const _LocalOverlaySupport({
    required this.child,
  });

  @override
  _LocalOverlaySupportState createState() => _LocalOverlaySupportState();
}

class _LocalOverlaySupportState
    extends OverlaySupportState<_LocalOverlaySupport> {
  final GlobalKey<OverlayState> _overlayStateKey = GlobalKey();

  @override
  OverlayState? get overlayState => _overlayStateKey.currentState;

  @override
  Widget build(BuildContext context) {
    return Overlay(
      key: _overlayStateKey,
      initialEntries: [OverlayEntry(builder: (context) => widget.child)],
    );
  }
}

abstract class OverlaySupportState<T extends StatefulWidget> extends State<T> {
  final Map<Key, OverlaySupportEntry> _entries = HashMap();

  OverlayState? get overlayState;

  OverlaySupportEntry? getEntry({required Key key}) {
    return _entries[key];
  }

  void addEntry(OverlaySupportEntry entry, {required Key key}) {
    _entries[key] = entry;
  }

  void removeEntry({required Key key}) {
    _entries.remove(key);
  }
}
