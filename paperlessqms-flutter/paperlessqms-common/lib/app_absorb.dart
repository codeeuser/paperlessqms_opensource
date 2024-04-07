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

class AppAbsorb extends ChangeNotifier {

  final SharedPreferences prefs;
  AppAbsorb({required this.prefs});

  bool _absorbing = false;
  set absorbing(bool absorbing){
    _absorbing = absorbing;
    notifyListeners();
  }
  bool get absorbing => _absorbing;

  bool _recaptcha = false;
  set recaptcha(bool recaptcha){
    prefs.setBool(Prefs.recaptcha, recaptcha);
    _recaptcha = recaptcha;
    notifyListeners();
  }
  bool get recaptcha {
    bool? recaptcha = prefs.getBool(Prefs.recaptcha);
    if (recaptcha!=null){
      return recaptcha;
    }
    return _recaptcha;
  }
}