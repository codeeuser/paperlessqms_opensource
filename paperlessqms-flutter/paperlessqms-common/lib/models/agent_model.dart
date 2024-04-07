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
import 'package:common/models/account_model.dart';
import 'package:common/models/queue_department_model.dart';
import 'package:common/models/queue_terminal_model.dart';

class AgentModel {
  int? id;
  int? profileBizId;
  int? uid;
  String? login;
  String? email;
  int? updateUid;
  bool? enable;
  int? orderNum;
  int? createdDate;
  int? modifiedDate;
  QueueTerminalModel? queueTerminal;
  QueueDepartmentModel? queueDepartment;
  AccountModel? account;
  
  AgentModel({
    this.id,
    this.profileBizId,
    this.uid,
    this.login,
    this.email,
    this.updateUid,
    this.enable,
    this.orderNum,
    this.queueDepartment,
    this.queueTerminal,
    this.account,
    this.createdDate,
    this.modifiedDate,
  });
  
  AgentModel.fromMap(Map<dynamic, dynamic> map)
      : id = map['id'],
      profileBizId = map['profileBizId'],
      uid = map['uid'],
      login = map['login'],
      email = map['email'],
      updateUid = map['updateUid'],
      enable = map['enable'],
      orderNum = map['orderNum'],
      queueDepartment = (map["queueDepartment"]!=null)? QueueDepartmentModel.fromMap(map["queueDepartment"]): null,
      queueTerminal = (map["queueTerminal"]!=null)? QueueTerminalModel.fromMap(map["queueTerminal"]): null,
      account = (map["account"]!=null)? AccountModel.fromMap(map["account"]): null,
      createdDate = map['createdDate'],
      modifiedDate = map['modifiedDate'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profileBizId': profileBizId,
      'uid': uid,
      'login': login,
      'email': email,
      'updateUid': updateUid,
      'enable': enable,
      'orderNum': orderNum,
      'queueDepartment': queueDepartment?.toJson(),
      'queueTerminal': queueTerminal?.toJson(),
      'account': account?.toJson(),
      'createdDate': createdDate,
      'modifiedDate': modifiedDate,
    };
  }

  @override
  String toString() {
    return 'AgentModel(id: $id, profileBizId: $profileBizId, uid: $uid, login: $login, email: $email, updateUid: $updateUid, enable: $enable, orderNum: $orderNum, createdDate: $createdDate, modifiedDate: $modifiedDate, queueTerminal: $queueTerminal, queueDepartment: $queueDepartment, account: $account)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AgentModel &&
      other.id == id &&
      other.profileBizId == profileBizId &&
      other.uid == uid &&
      other.login == login &&
      other.email == email &&
      other.updateUid == updateUid &&
      other.enable == enable &&
      other.orderNum == orderNum &&
      other.createdDate == createdDate &&
      other.modifiedDate == modifiedDate &&
      other.queueTerminal == queueTerminal &&
      other.queueDepartment == queueDepartment &&
      other.account == account;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      profileBizId.hashCode ^
      uid.hashCode ^
      login.hashCode ^
      email.hashCode ^
      updateUid.hashCode ^
      enable.hashCode ^
      orderNum.hashCode ^
      createdDate.hashCode ^
      modifiedDate.hashCode ^
      queueTerminal.hashCode ^
      queueDepartment.hashCode ^
      account.hashCode;
  }
}
