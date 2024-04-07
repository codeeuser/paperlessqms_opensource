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
 * obtain it through the world-wide-web, please send an endHour
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


class MaxtokenModel {
  int? id;
  int? profileBizId;
  int? maxToken;
  int? dayNum;
  int? createdDate;
  int? modifiedDate;
  
  MaxtokenModel({
    this.id,
    this.profileBizId,
    this.maxToken,
    this.dayNum,
    this.createdDate,
    this.modifiedDate,
  });
  
  MaxtokenModel.fromMap(Map<dynamic, dynamic> map)
      : assert(map['profileBizId'] != null),
      assert(map['maxToken'] != null),
      assert(map['dayNum'] != null),
      id = map['id'],
      profileBizId = map['profileBizId'],
      maxToken = map['maxToken'],
      dayNum = map['dayNum'],
      createdDate = map['createdDate'],
      modifiedDate = map['modifiedDate'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profileBizId': profileBizId,
      'maxToken': maxToken,
      'dayNum': dayNum,
      'createdDate': createdDate,
      'modifiedDate': modifiedDate,
    };
  }


  @override
  String toString() {
    return 'MaxtokenModel(id: $id, profileBizId: $profileBizId, maxToken: $maxToken, dayNum: $dayNum, createdDate: $createdDate, modifiedDate: $modifiedDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is MaxtokenModel &&
      other.id == id &&
      other.profileBizId == profileBizId &&
      other.maxToken == maxToken &&
      other.dayNum == dayNum &&
      other.createdDate == createdDate &&
      other.modifiedDate == modifiedDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      profileBizId.hashCode ^
      maxToken.hashCode ^
      dayNum.hashCode ^
      createdDate.hashCode ^
      modifiedDate.hashCode;
  }
}
