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
import 'package:common/models/agent_model.dart';
import 'package:common/models/queue_department_model.dart';
import 'package:common/models/queue_service_model.dart';

class QueueTerminalModel {
  int? id;
  String? key;
  String? name;
  int? profileBizId;
  int? createdDate;
  int? modifiedDate;
  bool? enable;
  int? orderNum;
  QueueDepartmentModel? queueDepartment;
  List<AgentModel>? agents;
  List<QueueServiceModel>? queueServices;

  QueueTerminalModel({
    this.id,
    this.key,
    this.name,
    this.profileBizId,
    this.createdDate,
    this.modifiedDate,
    this.enable,
    this.orderNum,
    this.queueDepartment,
    this.agents,
    this.queueServices,
  });

  QueueTerminalModel.fromMap(Map<dynamic, dynamic> map)
      : id = map['id'],
        key = map['key'],
        name = map['name'],
        createdDate = map['createdDate'],
        modifiedDate = map['modifiedDate'],
        enable = map['enable'],
        orderNum = map['orderNum'],
        profileBizId = map['profileBizId'],
        queueDepartment = (map["queueDepartment"]!=null)? QueueDepartmentModel.fromMap(map["queueDepartment"]): null,
        agents = (map['agents']!=null)? List<AgentModel>.from(map['agents'].map((x) => AgentModel.fromMap(x))).toList(): null,
        queueServices = (map['queueServices']!=null)? List<QueueServiceModel>.from(map['queueServices'].map((x) => QueueServiceModel.fromMap(x))).toList(): null;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'key': key,
      'name': name,
      'createdDate': createdDate,
      'modifiedDate': modifiedDate,
      'enable': enable,
      'orderNum': orderNum,
      'profileBizId': profileBizId,
      'queueDepartment': queueDepartment?.toJson(),
      'agents': List<AgentModel>.from(agents?.map((x) => x) ?? [].toList()),
      'queueServices': List<QueueServiceModel>.from(queueServices?.map((x) => x) ?? [].toList()),
    };
  }

  @override
  String toString() {
    return 'QueueTerminalModel(id: $id, key: $key, name: $name, profileBizId: $profileBizId, createdDate: $createdDate, modifiedDate: $modifiedDate, enable: $enable, orderNum: $orderNum, queueDepartment: $queueDepartment, agents: $agents, queueServices: $queueServices)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is QueueTerminalModel &&
      other.id == id &&
      other.key == key &&
      other.name == name &&
      other.profileBizId == profileBizId &&
      other.createdDate == createdDate &&
      other.modifiedDate == modifiedDate &&
      other.enable == enable &&
      other.orderNum == orderNum &&
      other.queueDepartment == queueDepartment &&
      listEquals(other.agents, agents) &&
      listEquals(other.queueServices, queueServices);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      key.hashCode ^
      name.hashCode ^
      profileBizId.hashCode ^
      createdDate.hashCode ^
      modifiedDate.hashCode ^
      enable.hashCode ^
      orderNum.hashCode ^
      queueDepartment.hashCode ^
      agents.hashCode ^
      queueServices.hashCode;
  }
}
