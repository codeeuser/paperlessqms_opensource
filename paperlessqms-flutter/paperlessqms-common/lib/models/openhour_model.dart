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


class OpenhourModel {
  int? id;
  int? profileBizId;
  int? startHour;
  int? startMin;
  int? endHour;
  int? endMin;
  int? dayNum;
  bool? enable;
  int? createdDate;
  int? modifiedDate;
  
  OpenhourModel({
    this.id,
    this.profileBizId,
    this.startHour,
    this.startMin,
    this.endHour,
    this.endMin,
    this.dayNum,
    this.enable,
    this.createdDate,
    this.modifiedDate,
  });
  
  OpenhourModel.fromMap(Map<dynamic, dynamic> map)
      : assert(map['profileBizId'] != null),
      assert(map['startHour'] != null),
      assert(map['startMin'] != null),
      assert(map['endHour'] != null),
      assert(map['endMin'] != null),
      assert(map['dayNum'] != null),
      id = map['id'],
      profileBizId = map['profileBizId'],
      startHour = map['startHour'],
      startMin = map['startMin'],
      endHour = map['endHour'],
      endMin = map['endMin'],
      dayNum = map['dayNum'],
      enable = map['enable'],
      createdDate = map['createdDate'],
      modifiedDate = map['modifiedDate'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profileBizId': profileBizId,
      'startHour': startHour,
      'startMin': startMin,
      'endHour': endHour,
      'endMin': endMin,
      'dayNum': dayNum,
      'enable': enable,
      'createdDate': createdDate,
      'modifiedDate': modifiedDate,
    };
  }


  @override
  String toString() {
    return 'OpenhourModel(id: $id, profileBizId: $profileBizId, startHour: $startHour, startMin: $startMin, endHour: $endHour, endMin: $endMin, dayNum: $dayNum, enable: $enable, createdDate: $createdDate, modifiedDate: $modifiedDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is OpenhourModel &&
      other.id == id &&
      other.profileBizId == profileBizId &&
      other.startHour == startHour &&
      other.startMin == startMin &&
      other.endHour == endHour &&
      other.endMin == endMin &&
      other.dayNum == dayNum &&
      other.enable == enable &&
      other.createdDate == createdDate &&
      other.modifiedDate == modifiedDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      profileBizId.hashCode ^
      startHour.hashCode ^
      startMin.hashCode ^
      endHour.hashCode ^
      endMin.hashCode ^
      dayNum.hashCode ^
      enable.hashCode ^
      createdDate.hashCode ^
      modifiedDate.hashCode;
  }
}
