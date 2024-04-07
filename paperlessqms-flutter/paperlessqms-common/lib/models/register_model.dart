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
class RegisterModel {
  String? email;
  String? langKey;
  String? login;
  String? password;
  RegisterModel({
    this.email,
    this.langKey,
    this.login,
    this.password,
  });
  
  RegisterModel.fromMap(Map<dynamic, dynamic> map)
    : email = map['email'],
    langKey = map['langKey'],
    login = map['login'],
    password = map['password'];

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'langKey': langKey,
      'login': login,
      'password': password,
    };
  }

  @override
  String toString() {
    return 'RegisterModel(email: $email, langKey: $langKey, login: $login, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is RegisterModel &&
      other.email == email &&
      other.langKey == langKey &&
      other.login == login &&
      other.password == password;
  }

  @override
  int get hashCode {
    return email.hashCode ^
      langKey.hashCode ^
      login.hashCode ^
      password.hashCode;
  }
}
