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
class ProfileBizModel {
  int? id;
  String? bizName;
  String? bizLogoBase64;
  String? bizPhotoBase64;
  String? bizAddress;
  int? bizLevel;
  String? bizEmail;
  String? bizPhoneNumber;
  String? bizPhoneCode;
  String? bizPhoneIsoCode;
  String? bizWebsite;
  String? bizDesc;
  bool? enable;
  int? createdByUid;
  int? updatedByUid;
  int? modifiedDate;
  int? createdDate;

  ProfileBizModel({
    this.id,
    this.bizName,
    this.bizLogoBase64,
    this.bizPhotoBase64,
    this.bizAddress,
    this.bizLevel,
    this.bizEmail,
    this.bizPhoneNumber,
    this.bizPhoneCode,
    this.bizPhoneIsoCode,
    this.bizWebsite,
    this.bizDesc,
    this.enable,
    this.createdByUid,
    this.updatedByUid,
    this.modifiedDate,
    this.createdDate,
  });

  ProfileBizModel.fromMap(Map<dynamic, dynamic> map)
      : assert(map['bizName'] != null),
        id = map['id'],
        bizName = map['bizName'],
        bizLogoBase64 = map['bizLogoBase64'],
        bizPhotoBase64 = map['bizPhotoBase64'],
        bizAddress = map['bizAddress'],
        bizLevel = map['bizLevel'],
        bizEmail = map['bizEmail'],
        bizPhoneNumber = map['bizPhoneNumber'],
        bizPhoneCode = map['bizPhoneCode'],
        bizPhoneIsoCode = map['bizPhoneIsoCode'],
        bizWebsite = map['bizWebsite'],
        bizDesc = map['bizDesc'],
        enable = map['enable'],
        createdByUid = map['createdByUid'],
        updatedByUid = map['updatedByUid'],
        createdDate = map['createdDate'],
        modifiedDate = map['modifiedDate'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bizName': bizName,
      'bizLogoBase64': bizLogoBase64,
      'bizPhotoBase64': bizPhotoBase64,
      'bizAddress': bizAddress,
      'bizLevel': bizLevel,
      'bizEmail': bizEmail,
      'bizPhoneNumber': bizPhoneNumber,
      'bizPhoneCode': bizPhoneCode,
      'bizPhoneIsoCode': bizPhoneIsoCode,
      'bizWebsite': bizWebsite,
      'bizDesc': bizDesc,
      'enable': enable,
      'createdByUid': createdByUid,
      'updatedByUid': updatedByUid,
      'createdDate': createdDate,
      'modifiedDate': modifiedDate,
    };
  }

  @override
  String toString() {
    return 'ProfileBizModel(id: $id, bizName: $bizName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ProfileBizModel &&
      other.id == id &&
      other.bizName == bizName &&
      other.bizLogoBase64 == bizLogoBase64 &&
      other.bizPhotoBase64 == bizPhotoBase64 &&
      other.bizAddress == bizAddress &&
      other.bizLevel == bizLevel &&
      other.bizEmail == bizEmail &&
      other.bizPhoneNumber == bizPhoneNumber &&
      other.bizPhoneCode == bizPhoneCode &&
      other.bizPhoneIsoCode == bizPhoneIsoCode &&
      other.bizWebsite == bizWebsite &&
      other.bizDesc == bizDesc &&
      other.enable == enable &&
      other.createdByUid == createdByUid &&
      other.updatedByUid == updatedByUid &&
      other.modifiedDate == modifiedDate &&
      other.createdDate == createdDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      bizName.hashCode ^
      bizLogoBase64.hashCode ^
      bizPhotoBase64.hashCode ^
      bizAddress.hashCode ^
      bizLevel.hashCode ^
      bizEmail.hashCode ^
      bizPhoneNumber.hashCode ^
      bizPhoneCode.hashCode ^
      bizPhoneIsoCode.hashCode ^
      bizWebsite.hashCode ^
      bizDesc.hashCode ^
      enable.hashCode ^
      createdByUid.hashCode ^
      updatedByUid.hashCode ^
      modifiedDate.hashCode ^
      createdDate.hashCode;
  }
}
