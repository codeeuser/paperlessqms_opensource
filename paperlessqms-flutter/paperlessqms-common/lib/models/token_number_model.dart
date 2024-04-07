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
class TokenNumberModel {
  int? id;
  int? number;
  int? departmentId;
  int? serviceId;
  bool? reset;
  int? createdDate;
  int? modifiedDate;

  TokenNumberModel({
    this.id,
    this.number,
    this.departmentId,
    this.serviceId,
    this.reset,
    this.createdDate,
    this.modifiedDate,
  });

  TokenNumberModel.fromMap(Map<dynamic, dynamic> map)
      : id = map['id'],
        number = map['number'],
        departmentId = map['departmentId'],
        serviceId = map['serviceId'],
        reset = map['reset'],
        createdDate = map['createdDate'],
        modifiedDate = map['modifiedDate'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'number': number,
      'departmentId': departmentId,
      'serviceId': serviceId,
      'reset': reset,
      'createdDate': createdDate,
      'modifiedDate': modifiedDate,
    };
  }
}
