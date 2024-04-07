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
import 'package:string_validator/string_validator.dart';

class ValidateUtils {
  static String? validatePhone(String? value) {
    if (value==null || value.isEmpty) return 'Phone is required.';
    final RegExp nameExp = RegExp(r'(^\+[0-9]{2}|^\+[0-9]{2}\(0\)|^\(\+[0-9]{2}\)\(0\)|^00[0-9]{2}|^0)([0-9]{9}$|[0-9\-\s]{10}$)');
    if (!nameExp.hasMatch(value.trim())) {
      return 'Please enter only phone .';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value==null || value.isEmpty) return 'Email is required.';
    if (!isEmail(value.trim())) return 'Please enter only email.';
    return null;
  }

  static String? validateEmails(List<String>? value) {
    if (value==null || value.isEmpty) return 'Email is required.';
    bool b = true;
    for (String email in value) {
      b = b && isEmail(email.trim());
    }
    if (b==false) return 'Please enter only email.';
    return null;
  }

  static String? validateUrl(String? value, String field) {
    if (value==null || value.isEmpty) return 'URL is required for $field.';
    if (!isURL(value.toLowerCase().trim(), {'require_protocol': true})) return 'Please enter only URL with protocol for $field.';
    return null;
  }

  static String? validateWs(String value) {
    if (value.isEmpty) return 'WS is required.';
    if (!isURL(value.toLowerCase().trim(), {'protocols': ['ws', 'wss'], 'require_protocol': true})) return 'Please enter only WebSocket URL with protocol.';
    return null;
  }

  static String? validateText(String value) {
    if (value.isEmpty) return 'Text is required.';
    final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value.trim())) {
      return 'Please enter only alphabetical characters.';
    }
    return null;
  }

  static String? validateNotEmpty(String? value) {
    if (value==null || value.isEmpty) return 'Value is required.';
    return null;
  }

  static String? validateJson(String? value) {
    if (value==null || value.isEmpty) return 'Json is required.';
    try{
      bool b = isJson(value);
      return (b==false)? 'Json is invalid.': null;
    } catch (e){
      return 'JSON is required.';
    }
  }

  static String? validateNum(String value, int min, int max) {
    if (value.isEmpty) return 'Number is required.';
    try {
      int d = int.parse(value.trim());
      if (d>=min && d<=max){
        return null;
      } 
    } catch (exception) {
      return 'Please enter valid number';
    }
    return 'Please enter number only between $min and $max.';
  }

  static String? validateDoubleValue(String? value) {
    if (value==null || value.isEmpty) return 'Number is required.';
    try {
      double.parse(value.trim());
    } catch (exception) {
      return 'Please enter valid number';
    }
    return 'Please enter number only';
  }

  static String? validateDouble(String? value, double min, double max) {
    if (value==null || value.isEmpty) return 'Number is required.';
    try {
      double d = double.parse(value.trim());
      if (d>=min && d<=max){
        return null;
      } 
    } catch (exception) {
      return 'Please enter valid number';
    }
    return 'Please enter number only between $min and $max.';
  }

  static String? validateStringMinMax(String? value, int min, int max, String field) {
    if (value==null || value.isEmpty) return '$field Input is required.';
    if (value.trim().length < min){
      return 'Please enter at least $min characters for $field.';
    }
    if (value.trim().length > max){
      return 'Please enter only $max characters for $field.';
    }
    return null;
  }

  static String? validateDigitMinMax(String? value, int min, int max) {
    if (value==null || value.isEmpty) return 'Input is required.';
    int? iValue = int.tryParse(value);
    if (iValue==null) return 'Input MUST be digits';
    if (iValue < min){
      return 'Please enter greater than or equal to $min';
    }
    if (iValue > max){
      return 'Please enter less than or equal to $max digits.';
    }
    return null;
  }

  static String? validateAlphanumericMinMax(String? value, int min, int max) {
    if (value==null || value.isEmpty) return 'Input is required.';
    if (!isAlphanumeric(value)) return 'Alphanumeric is required.';
    if (value.trim().length < min){
      return 'Please enter at least $min characters.';
    }
    if (value.trim().length > max){
      return 'Please enter only $max characters.';
    }
    return null;
  }

  static String? validateFilenameMinMax(String? value, int min, int max) {
    if (value==null || value.isEmpty) return 'Input is required.';
    if (isLength(value.trim(), min, max)==false){
      return 'Please enter at least $min characters and at most $max characters.';
    }
    return null;
  }

  static String? validateDeleteAccount(String? value){
    if (value==null || value.isEmpty) return 'Input is required.';
    if (value!='DELETE'){
      return 'Please enter "DELETE" in uppercase.';
    }
    return null;
  }

  static String? validateLat(String value) {
    if (value.isEmpty) return 'Number Decimal is required.';
    double lat = double.parse(value.trim());
    if (!(lat>=-90 && lat <=90)) {
      return 'Please enter only latitude. (-90.0>=lat && lat<=90.0).';
    }
    return null;
  }

  static String? validateLng(String value) {
    if (value.isEmpty) return 'Number Decimal is required.';
    double lng = double.parse(value.trim());
    if (!(lng>=-180 && lng <=180)) {
      return 'Please enter only longitude. (-180.0>=lng && lng<=180.0).';
    }
    return null;
  }

  static String? validateInt(String? value) {
    if (value==null || value.isEmpty) return 'Number is required.';
    final RegExp nameExp = RegExp(r'^\d+$');
    if (!nameExp.hasMatch(value.trim())) {
      return 'Please enter only integer.';
    }
    return null;
  }
}