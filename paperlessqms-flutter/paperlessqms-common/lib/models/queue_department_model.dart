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
import 'package:common/models/queue_service_model.dart';

class QueueDepartmentModel {
  int? id;
  String? key;
  int? profileBizId;
  String? bizName;
  String? bizCategoryName;
  String? name;
  String? desc;
  double? lat;
  double? lng;
  int? timeZone;
  int? threshold;
  int? nearbyRange;
  int? tokenTimeoutMin;
  bool? selected;
  bool? enable;
  int? orderNum;
  String? currencySymbol;
  String? lenMetric;
  String? currencyCode;
  String? bannerName;
  int? modifiedDate;
  int? createdDate;
  List<QueueServiceModel>? queueServices;

  QueueDepartmentModel({
    this.id,
    this.key,
    this.profileBizId,
    this.bizName,
    this.bizCategoryName,
    this.name,
    this.desc,
    this.lat,
    this.lng,
    this.timeZone,
    this.threshold,
    this.nearbyRange,
    this.tokenTimeoutMin,
    this.selected,
    this.enable,
    this.orderNum,
    this.currencySymbol,
    this.lenMetric,
    this.currencyCode,
    this.bannerName,
    this.createdDate,
    this.modifiedDate,
    this.queueServices,
  });

  QueueDepartmentModel.fromMap(Map<dynamic, dynamic> map)
      : id = map['id'],
        key = map['key'],
        profileBizId = map['profileBizId'],
        bizName = map['bizName'],
        bizCategoryName = map['bizCategoryName'],
        name = map['name'],
        desc = map['desc'],
        lat = (map['lat'] is int) ? map['lat'] + .0 : map['lat'],
        lng = (map['lng'] is int) ? map['lng'] + .0 : map['lng'],
        timeZone = map['timeZone'],
        threshold = map['threshold'],
        nearbyRange = map['nearbyRange'],
        tokenTimeoutMin = map['tokenTimeoutMin'],
        selected = map['selected'],
        enable = map['enable'],
        orderNum = map['orderNum'],
        currencySymbol = map['currencySymbol'],
        lenMetric = map['lenMetric'],
        currencyCode = map['currencyCode'],
        bannerName = map['bannerName'],
        createdDate = map['createdDate'],
        modifiedDate = map['modifiedDate'],
        queueServices = (map['queueServices']!=null)? List<QueueServiceModel>.from(map['queueServices'].map((x) => QueueServiceModel.fromMap(x))).toList(): null;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'key': key,
      'profileBizId': profileBizId,
      'bizName': bizName,
      'bizCategoryName': bizCategoryName,
      'name': name,
      'desc': desc,
      'lat': lat,
      'lng': lng,
      'timeZone': timeZone,
      'threshold': threshold,
      'nearbyRange': nearbyRange,
      'tokenTimeoutMin': tokenTimeoutMin,
      'selected': selected,
      'enable': enable,
      'orderNum': orderNum,
      'currencySymbol': currencySymbol,
      'lenMetric': lenMetric,
      'currencyCode': currencyCode,
      'bannerName': bannerName,
      'createdDate': createdDate,
      'modifiedDate': modifiedDate,
      'queueServices': List<QueueServiceModel>.from(queueServices?.map((x) => x) ?? [].toList()),
    };
  }


  @override
  String toString() {
    return 'QueueDepartmentModel(id: $id, key: $key, profileBizId: $profileBizId, bizName: $bizName, bizCategoryName: $bizCategoryName, name: $name, desc: $desc, lat: $lat, lng: $lng, timeZone: $timeZone, threshold: $threshold, nearbyRange: $nearbyRange, tokenTimeoutMin: $tokenTimeoutMin, selected: $selected, enable: $enable, orderNum: $orderNum, currencySymbol: $currencySymbol, lenMetric: $lenMetric, currencyCode: $currencyCode, bannerName: $bannerName, modifiedDate: $modifiedDate, createdDate: $createdDate, queueServices: $queueServices)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is QueueDepartmentModel &&
      other.id == id &&
      other.key == key &&
      other.profileBizId == profileBizId &&
      other.bizName == bizName &&
      other.bizCategoryName == bizCategoryName &&
      other.name == name &&
      other.desc == desc &&
      other.lat == lat &&
      other.lng == lng &&
      other.timeZone == timeZone &&
      other.threshold == threshold &&
      other.nearbyRange == nearbyRange &&
      other.tokenTimeoutMin == tokenTimeoutMin &&
      other.selected == selected &&
      other.enable == enable &&
      other.orderNum == orderNum &&
      other.currencySymbol == currencySymbol &&
      other.lenMetric == lenMetric &&
      other.currencyCode == currencyCode &&
      other.bannerName == bannerName &&
      other.modifiedDate == modifiedDate &&
      other.createdDate == createdDate &&
      listEquals(other.queueServices, queueServices);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      key.hashCode ^
      profileBizId.hashCode ^
      bizName.hashCode ^
      bizCategoryName.hashCode ^
      name.hashCode ^
      desc.hashCode ^
      lat.hashCode ^
      lng.hashCode ^
      timeZone.hashCode ^
      threshold.hashCode ^
      nearbyRange.hashCode ^
      tokenTimeoutMin.hashCode ^
      selected.hashCode ^
      enable.hashCode ^
      orderNum.hashCode ^
      currencySymbol.hashCode ^
      lenMetric.hashCode ^
      currencyCode.hashCode ^
      bannerName.hashCode ^
      modifiedDate.hashCode ^
      createdDate.hashCode ^
      queueServices.hashCode;
  }
}
