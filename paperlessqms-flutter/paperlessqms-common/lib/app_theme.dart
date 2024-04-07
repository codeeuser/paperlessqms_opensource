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
import 'package:common/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppTheme extends ChangeNotifier {
  final SharedPreferences prefs;
  AppTheme({required this.prefs});

  ThemeMode _mode = ThemeMode.light;
  ThemeMode get mode {
    String? modeName = prefs.getString(Prefs.themeMode);
    if (modeName!=null){
      if (modeName==ThemeMode.light.name){
        return ThemeMode.light;
      } else if (modeName==ThemeMode.dark.name){
        return ThemeMode.dark;
      }
    }
    return _mode;
  }
  set mode(ThemeMode mode){
    _mode = mode;
    prefs.setString(Prefs.themeMode, mode.name);
    notifyListeners();
  }
}
