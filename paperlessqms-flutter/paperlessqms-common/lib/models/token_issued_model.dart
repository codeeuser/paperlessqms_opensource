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
import 'package:common/models/profile_biz_model.dart';

class TokenIssuedModel {
  int? id;
  int? uid;
  String? userPhone;
  String? phoneISOCode;
  String? phoneCode;
  String? userEmail;
  String? userFirstName;
  String? userLastName;
  String? tokenLetter;
  int? tokenNumber;
  String? serviceName;
  int? serviceId;
  String? terminalName;
  int? terminalId;
  String? orgTerminalName;
  int? orgTerminalId;
  String? statusName;
  int? statusCode;
  bool? isPending;
  bool? isQueue;
  bool? isReject;
  bool? isAbsent;
  bool? isCancel;
  bool? isRecall;
  bool? isCompleted;
  bool? isTimeout;
  int? assignedDate;
  int? assignedYear;
  int? assignedMonth;
  int? assignedDay;
  int? assignedHour;
  int? assignedMin;
  int? assignedTimeZoneOffset;
  String? assignedTimeZoneName;
  String? assignedNow;
  int? createdDate;
  int? modifiedDate;
  int? completedYear;
  int? completedMonth;
  int? completedDay;
  int? completedHour;
  int? completedMin;
  int? completedDate;
  int? completedTimeZoneOffset;
  String? completedTimeZoneName;
  String? completedNow;
  int? transferedYear;
  int? transferedMonth;
  int? transferedDay;
  int? transferedHour;
  int? transferedMin;
  int? transferedDate;
  int? transferedTimeZoneOffset;
  String? transferedTimeZoneName;
  String? transferedNow;
  int? transferedUid;
  int? createdYear;
  int? createdMonth;
  int? createdDay;
  int? createdHour;
  int? createdMin;
  int? createdTimeZoneOffset;
  String? createdTimeZoneName;
  String? createdNow;
  int? modifiedYear;
  int? modifiedMonth;
  int? modifiedDay;
  int? modifiedHour;
  int? modifiedMin;
  int? modifiedTimeZoneOffset;
  String? modifiedTimeZoneName;
  String? modifiedNow;
  String? issuedFrom;
  int? departmentId;
  String? departmentName;
  int? profileBizId;
  ProfileBizModel? profileBiz;
  String? bizName;
  double? rating;
  String? feedback;
  String? topicKey;
  int? smsComingCount;
  int? pushComingCount;
  int? orderId;
  int? assignedUid;
  int? completedUid;
  bool? reset;
  int? resetDate;
  int? resetUid;

  TokenIssuedModel({
    this.id,
    this.uid,
    this.userPhone,
    this.phoneISOCode,
    this.phoneCode,
    this.userEmail,
    this.userFirstName,
    this.userLastName,
    this.tokenLetter,
    this.tokenNumber,
    this.serviceName,
    this.serviceId,
    this.terminalName,
    this.terminalId,
    this.orgTerminalName,
    this.orgTerminalId,
    this.statusName,
    this.statusCode,
    this.isPending,
    this.isQueue,
    this.isReject,
    this.isAbsent,
    this.isCancel,
    this.isRecall,
    this.isCompleted,
    this.isTimeout,
    this.assignedDate,
    this.assignedYear,
    this.assignedMonth,
    this.assignedDay,
    this.assignedHour,
    this.assignedMin,
    this.assignedTimeZoneOffset,
    this.assignedTimeZoneName,
    this.assignedNow,
    this.createdDate,
    this.modifiedDate,
    this.completedYear,
    this.completedMonth,
    this.completedDay,
    this.completedHour,
    this.completedMin,
    this.completedDate,
    this.completedTimeZoneOffset,
    this.completedTimeZoneName,
    this.completedNow,
    this.transferedYear,
    this.transferedMonth,
    this.transferedDay,
    this.transferedHour,
    this.transferedMin,
    this.transferedDate,
    this.transferedTimeZoneOffset,
    this.transferedTimeZoneName,
    this.transferedNow,
    this.transferedUid,
    this.createdYear,
    this.createdMonth,
    this.createdDay,
    this.createdHour,
    this.createdMin,
    this.createdTimeZoneOffset,
    this.createdTimeZoneName,
    this.createdNow,
    this.modifiedYear,
    this.modifiedMonth,
    this.modifiedDay,
    this.modifiedHour,
    this.modifiedMin,
    this.modifiedTimeZoneOffset,
    this.modifiedTimeZoneName,
    this.modifiedNow,
    this.issuedFrom,
    this.departmentId,
    this.departmentName,
    this.profileBizId,
    this.profileBiz,
    this.bizName,
    this.rating,
    this.feedback,
    this.topicKey,
    this.smsComingCount,
    this.pushComingCount,
    this.orderId,
    this.assignedUid,
    this.completedUid,
    this.reset,
    this.resetDate,
    this.resetUid,
  });

  TokenIssuedModel.fromMap(Map<dynamic, dynamic> map)
      : assert(map['uid'] != null),
        assert(map['tokenLetter'] != null),
        assert(map['tokenNumber'] != null),
        assert(map['serviceName'] != null),
        assert(map['serviceId'] != null),
        id = map['id'],
        uid = map['uid'],
        userPhone = map['userPhone'],
        phoneCode = map['phoneCode'],
        phoneISOCode = map['phoneISOCode'],
        userEmail = map['userEmail'],
        userFirstName = map['userFirstName'],
        userLastName = map['userLastName'],
        tokenLetter = map['tokenLetter'],
        tokenNumber = map['tokenNumber'],
        serviceName = map['serviceName'],
        serviceId = map['serviceId'],
        terminalName = map['terminalName'],
        terminalId = map['terminalId'],
        orgTerminalName = map['orgTerminalName'],
        orgTerminalId = map['orgTerminalId'],
        statusName = map['statusName'],
        statusCode = map['statusCode'],
        isPending = map['isPending'],
        isQueue = map['isQueue'],
        isReject = map['isReject'],
        isAbsent = map['isAbsent'],
        isRecall = map['isRecall'],
        isCancel = map['isCancel'],
        isCompleted = map['isCompleted'],
        isTimeout = map['isTimeout'],
        assignedDate = map['assignedDate'],
        assignedYear = map['assignedYear'],
        assignedMonth = map['assignedMonth'],
        assignedDay = map['assignedDay'],
        assignedHour = map['assignedHour'],
        assignedMin = map['assignedMin'],
        assignedTimeZoneOffset = map['assignedTimeZoneOffset'],
        assignedTimeZoneName = map['assignedTimeZoneName'],
        assignedNow = map['assignedNow'],
        createdDate = map['createdDate'],
        modifiedDate = map['modifiedDate'],
        completedYear = map['completedYear'],
        completedMonth = map['completedMonth'],
        completedDay = map['completedDay'],
        completedHour = map['completedHour'],
        completedMin = map['completedMin'],
        completedDate = map['completedDate'],
        completedTimeZoneOffset = map['completedTimeZoneOffset'],
        completedTimeZoneName = map['completedTimeZoneName'],
        completedNow = map['completedNow'],
        createdYear = map['createdYear'],
        createdMonth = map['createdMonth'],
        createdDay = map['createdDay'],
        createdHour = map['createdHour'],
        createdMin = map['createdMin'],
        createdTimeZoneOffset = map['createdTimeZoneOffset'],
        createdTimeZoneName = map['createdTimeZoneName'],
        createdNow = map['createdNow'],
        modifiedYear = map['modifiedYear'],
        modifiedMonth = map['modifiedMonth'],
        modifiedDay = map['modifiedDay'],
        modifiedHour = map['modifiedHour'],
        modifiedMin = map['modifiedMin'],
        modifiedTimeZoneOffset = map['modifiedTimeZoneOffset'],
        modifiedTimeZoneName = map['modifiedTimeZoneName'],
        modifiedNow = map['modifiedNow'],
        transferedYear = map['transferedYear'],
        transferedMonth = map['transferedMonth'],
        transferedDay = map['transferedDay'],
        transferedHour = map['transferedHour'],
        transferedMin = map['transferedMin'],
        transferedDate = map['transferedDate'],
        transferedTimeZoneOffset = map['transferedTimeZoneOffset'],
        transferedTimeZoneName = map['transferedTimeZoneName'],
        transferedNow = map['transferedNow'],
        transferedUid = map['transferedUid'],
        issuedFrom = map['issuedFrom'],
        departmentId = map['departmentId'],
        departmentName = map['departmentName'],
        profileBizId = map['profileBizId'],
        profileBiz = (map["profileBiz"]!=null)? ProfileBizModel.fromMap(map["profileBiz"]): null,
        bizName = map['bizName'],
        rating = map['rating'],
        feedback = map['feedback'],
        topicKey = map['topicKey'],
        smsComingCount = map['smsComingCount'],
        pushComingCount = map['pushComingCount'],
        orderId = map['orderId'],
        assignedUid = map['assignedUid'],
        completedUid = map['completedUid'],
        reset = map['reset'],
        resetDate = map['resetDate'],
        resetUid = map['resetUid'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'userPhone': userPhone,
      'phoneCode': phoneCode,
      'phoneISOCode': phoneISOCode,
      'userEmail': userEmail,
      'userFirstName': userFirstName,
      'userLastName': userLastName,
      'tokenLetter': tokenLetter,
      'tokenNumber': tokenNumber,
      'serviceName': serviceName,
      'serviceId': serviceId,
      'terminalName': terminalName,
      'terminalId': terminalId,
      'orgTerminalName': orgTerminalName,
      'orgTerminalId': orgTerminalId,
      'statusName': statusName,
      'statusCode': statusCode,
      'isPending': isPending,
      'isQueue': isQueue,
      'isReject': isReject,
      'isAbsent': isAbsent,
      'isCancel': isCancel,
      'isRecall': isRecall,
      'isCompleted': isCompleted,
      'isTimeout': isTimeout,
      'assignedDate': assignedDate,
      'assignedYear': assignedYear,
      'assignedMonth': assignedMonth,
      'assignedDay': assignedDay,
      'assignedHour': assignedHour,
      'assignedMin': assignedMin,
      'assignedTimeZoneOffset': assignedTimeZoneOffset,
      'assignedTimeZoneName': assignedTimeZoneName,
      'assignedNow': assignedNow,
      'createdDate': createdDate,
      'modifiedDate': modifiedDate,
      'completedYear': completedYear,
      'completedMonth': completedMonth,
      'completedDay': completedDay,
      'completedHour': completedHour,
      'completedMin': completedMin,
      'completedDate': completedDate,
      'completedTimeZoneOffset': completedTimeZoneOffset,
      'completedTimeZoneName': completedTimeZoneName,
      'completedNow': completedNow,
      'transferedYear': transferedYear,
      'transferedMonth': transferedMonth,
      'transferedDay': transferedDay,
      'transferedHour': transferedHour,
      'transferedMin': transferedMin,
      'transferedDate': transferedDate,
      'transferedTimeZoneOffset': transferedTimeZoneOffset,
      'transferedTimeZoneName': transferedTimeZoneName,
      'transferedNow': transferedNow,
      'transferedUid': transferedUid,
      'createdYear': createdYear,
      'createdMonth': createdMonth,
      'createdDay': createdDay,
      'createdHour': createdHour,
      'createdMin': createdMin,
      'createdTimeZoneOffset': createdTimeZoneOffset,
      'createdTimeZoneName': createdTimeZoneName,
      'createdNow': createdNow,
      'modifiedYear': modifiedYear,
      'modifiedMonth': modifiedMonth,
      'modifiedDay': modifiedDay,
      'modifiedHour': modifiedHour,
      'modifiedMin': modifiedMin,
      'modifiedTimeZoneOffset': modifiedTimeZoneOffset,
      'modifiedTimeZoneName': modifiedTimeZoneName,
      'modifiedNow': modifiedNow,
      'issuedFrom': issuedFrom,
      'departmentId': departmentId,
      'departmentName': departmentName,
      'profileBizId': profileBizId,
      'profileBiz': profileBiz?.toJson(),
      'bizName': bizName,
      'rating': rating,
      'feedback': feedback,
      'topicKey': topicKey,
      'smsComingCount': smsComingCount,
      'pushComingCount': pushComingCount,
      'orderId': orderId,
      'assignedUid': assignedUid,
      'completedUid': completedUid,
      'reset': reset,
      'resetDate': resetDate,
      'resetUid': resetUid,
    };
  }

  @override
  String toString() {
    return 'TokenIssuedModel(id: $id)';
  }

  

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is TokenIssuedModel &&
      other.id == id &&
      other.uid == uid &&
      other.userPhone == userPhone &&
      other.phoneISOCode == phoneISOCode &&
      other.phoneCode == phoneCode &&
      other.userEmail == userEmail &&
      other.userFirstName == userFirstName &&
      other.userLastName == userLastName &&
      other.tokenLetter == tokenLetter &&
      other.tokenNumber == tokenNumber &&
      other.serviceName == serviceName &&
      other.serviceId == serviceId &&
      other.terminalName == terminalName &&
      other.terminalId == terminalId &&
      other.orgTerminalName == orgTerminalName &&
      other.orgTerminalId == orgTerminalId &&
      other.statusName == statusName &&
      other.statusCode == statusCode &&
      other.isPending == isPending &&
      other.isQueue == isQueue &&
      other.isReject == isReject &&
      other.isAbsent == isAbsent &&
      other.isCancel == isCancel &&
      other.isRecall == isRecall &&
      other.isCompleted == isCompleted &&
      other.isTimeout == isTimeout &&
      other.assignedDate == assignedDate &&
      other.assignedYear == assignedYear &&
      other.assignedMonth == assignedMonth &&
      other.assignedDay == assignedDay &&
      other.assignedHour == assignedHour &&
      other.assignedMin == assignedMin &&
      other.assignedTimeZoneOffset == assignedTimeZoneOffset &&
      other.assignedTimeZoneName == assignedTimeZoneName &&
      other.assignedNow == assignedNow &&
      other.createdDate == createdDate &&
      other.modifiedDate == modifiedDate &&
      other.completedYear == completedYear &&
      other.completedMonth == completedMonth &&
      other.completedDay == completedDay &&
      other.completedHour == completedHour &&
      other.completedMin == completedMin &&
      other.completedDate == completedDate &&
      other.completedTimeZoneOffset == completedTimeZoneOffset &&
      other.completedTimeZoneName == completedTimeZoneName &&
      other.completedNow == completedNow &&
      other.transferedYear == transferedYear &&
      other.transferedMonth == transferedMonth &&
      other.transferedDay == transferedDay &&
      other.transferedHour == transferedHour &&
      other.transferedMin == transferedMin &&
      other.transferedDate == transferedDate &&
      other.transferedTimeZoneOffset == transferedTimeZoneOffset &&
      other.transferedTimeZoneName == transferedTimeZoneName &&
      other.transferedNow == transferedNow &&
      other.transferedUid == transferedUid &&
      other.createdYear == createdYear &&
      other.createdMonth == createdMonth &&
      other.createdDay == createdDay &&
      other.createdHour == createdHour &&
      other.createdMin == createdMin &&
      other.createdTimeZoneOffset == createdTimeZoneOffset &&
      other.createdTimeZoneName == createdTimeZoneName &&
      other.createdNow == createdNow &&
      other.modifiedYear == modifiedYear &&
      other.modifiedMonth == modifiedMonth &&
      other.modifiedDay == modifiedDay &&
      other.modifiedHour == modifiedHour &&
      other.modifiedMin == modifiedMin &&
      other.modifiedTimeZoneOffset == modifiedTimeZoneOffset &&
      other.modifiedTimeZoneName == modifiedTimeZoneName &&
      other.modifiedNow == modifiedNow &&
      other.issuedFrom == issuedFrom &&
      other.departmentId == departmentId &&
      other.departmentName == departmentName &&
      other.profileBizId == profileBizId &&
      other.profileBiz == profileBiz &&
      other.bizName == bizName &&
      other.rating == rating &&
      other.feedback == feedback &&
      other.topicKey == topicKey &&
      other.smsComingCount == smsComingCount &&
      other.pushComingCount == pushComingCount &&
      other.orderId == orderId &&
      other.assignedUid == assignedUid &&
      other.completedUid == completedUid &&
      other.reset == reset &&
      other.resetDate == resetDate &&
      other.resetUid == resetUid;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      uid.hashCode ^
      userPhone.hashCode ^
      phoneISOCode.hashCode ^
      phoneCode.hashCode ^
      userEmail.hashCode ^
      userFirstName.hashCode ^
      userLastName.hashCode ^
      tokenLetter.hashCode ^
      tokenNumber.hashCode ^
      serviceName.hashCode ^
      serviceId.hashCode ^
      terminalName.hashCode ^
      terminalId.hashCode ^
      orgTerminalName.hashCode ^
      orgTerminalId.hashCode ^
      statusName.hashCode ^
      statusCode.hashCode ^
      isPending.hashCode ^
      isQueue.hashCode ^
      isReject.hashCode ^
      isAbsent.hashCode ^
      isCancel.hashCode ^
      isRecall.hashCode ^
      isCompleted.hashCode ^
      isTimeout.hashCode ^
      assignedDate.hashCode ^
      assignedYear.hashCode ^
      assignedMonth.hashCode ^
      assignedDay.hashCode ^
      assignedHour.hashCode ^
      assignedMin.hashCode ^
      assignedTimeZoneOffset.hashCode ^
      assignedTimeZoneName.hashCode ^
      assignedNow.hashCode ^
      createdDate.hashCode ^
      modifiedDate.hashCode ^
      completedYear.hashCode ^
      completedMonth.hashCode ^
      completedDay.hashCode ^
      completedHour.hashCode ^
      completedMin.hashCode ^
      completedDate.hashCode ^
      completedTimeZoneOffset.hashCode ^
      completedTimeZoneName.hashCode ^
      completedNow.hashCode ^
      transferedYear.hashCode ^
      transferedMonth.hashCode ^
      transferedDay.hashCode ^
      transferedHour.hashCode ^
      transferedMin.hashCode ^
      transferedDate.hashCode ^
      transferedTimeZoneOffset.hashCode ^
      transferedTimeZoneName.hashCode ^
      transferedNow.hashCode ^
      transferedUid.hashCode ^
      createdYear.hashCode ^
      createdMonth.hashCode ^
      createdDay.hashCode ^
      createdHour.hashCode ^
      createdMin.hashCode ^
      createdTimeZoneOffset.hashCode ^
      createdTimeZoneName.hashCode ^
      createdNow.hashCode ^
      modifiedYear.hashCode ^
      modifiedMonth.hashCode ^
      modifiedDay.hashCode ^
      modifiedHour.hashCode ^
      modifiedMin.hashCode ^
      modifiedTimeZoneOffset.hashCode ^
      modifiedTimeZoneName.hashCode ^
      modifiedNow.hashCode ^
      issuedFrom.hashCode ^
      departmentId.hashCode ^
      departmentName.hashCode ^
      profileBizId.hashCode ^
      profileBiz.hashCode ^
      bizName.hashCode ^
      rating.hashCode ^
      feedback.hashCode ^
      topicKey.hashCode ^
      smsComingCount.hashCode ^
      pushComingCount.hashCode ^
      orderId.hashCode ^
      assignedUid.hashCode ^
      completedUid.hashCode ^
      reset.hashCode ^
      resetDate.hashCode ^
      resetUid.hashCode;
  }
}
