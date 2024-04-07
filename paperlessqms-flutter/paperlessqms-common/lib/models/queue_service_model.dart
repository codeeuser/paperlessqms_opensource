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
import 'package:common/models/queue_department_model.dart';
import 'package:common/models/queue_terminal_model.dart';

class QueueServiceModel {
  int? id;
  String? key;
  int? profileBizId;
  String? name;
  String? type;
  String? letter;
  int? start;
  String? desc;
  bool? enable;
  int? orderNum;
  bool? enableCatalog;
  QueueDepartmentModel? queueDepartment;
  QueueTerminalModel? queueTerminal;
  int? createdDate;
  int? modifiedDate;

  QueueServiceModel({
    this.id,
    this.key,
    this.profileBizId,
    this.name,
    this.type,
    this.letter,
    this.start,
    this.desc,
    this.enable,
    this.orderNum,
    this.enableCatalog,
    this.queueDepartment,
    this.queueTerminal,
    this.createdDate,
    this.modifiedDate,
  });

  QueueServiceModel.fromMap(Map<dynamic, dynamic> map)
      : assert(map['name'] != null),
        id = map['id'],
        key = map['key'],
        profileBizId = map['profileBizId'],
        name = map['name'],
        type = map['type'],
        letter = map['letter'],
        start = map['start'],
        desc = map['desc'],
        enable = map['enable'],
        orderNum = map['orderNum'],
        enableCatalog = map['enableCatalog'],
        queueDepartment = (map["queueDepartment"]!=null)? QueueDepartmentModel.fromMap(map["queueDepartment"]): null,
        queueTerminal = (map["queueTerminal"]!=null)? QueueTerminalModel.fromMap(map["queueTerminal"]): null,
        createdDate = map['createdDate'],
        modifiedDate = map['modifiedDate'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'key': key,
      'profileBizId': profileBizId,
      'name': name,
      'type': type,
      'letter': letter,
      'start': start,
      'desc': desc,
      'enable': enable,
      'orderNum': orderNum,
      'enableCatalog': enableCatalog,
      'queueDepartment': queueDepartment?.toJson(),
      'queueTerminal': queueTerminal?.toJson(),
      'createdDate': createdDate,
      'modifiedDate': modifiedDate,
    };
  }


  @override
  String toString() {
    return 'QueueServiceModel(id: $id, key: $key, profileBizId: $profileBizId, name: $name, type: $type, letter: $letter, start: $start, desc: $desc, enable: $enable, orderNum: $orderNum, enableCatalog: $enableCatalog, queueDepartment: $queueDepartment, queueTerminal: $queueTerminal, createdDate: $createdDate, modifiedDate: $modifiedDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is QueueServiceModel &&
      other.id == id &&
      other.key == key &&
      other.profileBizId == profileBizId &&
      other.name == name &&
      other.type == type &&
      other.letter == letter &&
      other.start == start &&
      other.desc == desc &&
      other.enable == enable &&
      other.orderNum == orderNum &&
      other.enableCatalog == enableCatalog &&
      other.queueDepartment == queueDepartment &&
      other.queueTerminal == queueTerminal &&
      other.createdDate == createdDate &&
      other.modifiedDate == modifiedDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      key.hashCode ^
      profileBizId.hashCode ^
      name.hashCode ^
      type.hashCode ^
      letter.hashCode ^
      start.hashCode ^
      desc.hashCode ^
      enable.hashCode ^
      orderNum.hashCode ^
      enableCatalog.hashCode ^
      queueDepartment.hashCode ^
      queueTerminal.hashCode ^
      createdDate.hashCode ^
      modifiedDate.hashCode;
  }
}
