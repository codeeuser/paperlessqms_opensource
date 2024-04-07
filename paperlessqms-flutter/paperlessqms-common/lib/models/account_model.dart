import 'package:flutter/foundation.dart';

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

class AccountModel {
  int? id;
  String? key;
  String? login;
  String? firstName;
  String? lastName;
  String? email;
  String? imageUrl;
  bool? activated;
  String? langKey;
  String? createdBy;
  String? createdDate;
  String? lastModifiedBy;
  String? lastModifiedDate;
  List<String>? authorities;

  AccountModel({
    this.id,
    this.key,
    this.login,
    this.firstName,
    this.lastName,
    this.email,
    this.imageUrl,
    this.activated,
    this.langKey,
    this.createdBy,
    this.createdDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
    this.authorities,
  });

  AccountModel.fromMap(Map<dynamic, dynamic> map)
      : id = map['id'],
      key = map['key'],
      login = map['login'],
      firstName = map['firstName'],
      lastName = map['lastName'],
      email = map['email'],
      imageUrl = map['imageUrl'],
      activated = map['activated'],
      langKey = map['langKey'],
      createdBy = map['createdBy'],
      createdDate = map['createdDate'],
      lastModifiedBy = map['lastModifiedBy'],
      lastModifiedDate = map['lastModifiedDate'],
      authorities = (map['authorities']!=null)? List.from(map['authorities']): null;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'key': key,
      'login': login,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'imageUrl': imageUrl,
      'activated': activated,
      'langKey': langKey,
      'createdBy': createdBy,
      'createdDate': createdDate,
      'lastModifiedBy': lastModifiedBy,
      'lastModifiedDate': lastModifiedDate,
      'authorities': authorities,
    };
  }


  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AccountModel &&
      other.id == id &&
      other.key == key &&
      other.login == login &&
      other.firstName == firstName &&
      other.lastName == lastName &&
      other.email == email &&
      other.imageUrl == imageUrl &&
      other.activated == activated &&
      other.langKey == langKey &&
      other.createdBy == createdBy &&
      other.createdDate == createdDate &&
      other.lastModifiedBy == lastModifiedBy &&
      other.lastModifiedDate == lastModifiedDate &&
      listEquals(other.authorities, authorities);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      key.hashCode ^
      login.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      email.hashCode ^
      imageUrl.hashCode ^
      activated.hashCode ^
      langKey.hashCode ^
      createdBy.hashCode ^
      createdDate.hashCode ^
      lastModifiedBy.hashCode ^
      lastModifiedDate.hashCode ^
      authorities.hashCode;
  }
}
