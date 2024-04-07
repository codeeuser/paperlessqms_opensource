import { Injectable } from '@angular/core';
import { FormGroup, FormControl, Validators } from '@angular/forms';

import { ITokenIssued, NewTokenIssued } from '../token-issued.model';

/**
 * A partial Type with required key is used as form input.
 */
type PartialWithRequiredKeyOf<T extends { id: unknown }> = Partial<Omit<T, 'id'>> & { id: T['id'] };

/**
 * Type for createFormGroup and resetForm argument.
 * It accepts ITokenIssued for edit and NewTokenIssuedFormGroupInput for create.
 */
type TokenIssuedFormGroupInput = ITokenIssued | PartialWithRequiredKeyOf<NewTokenIssued>;

type TokenIssuedFormDefaults = Pick<
  NewTokenIssued,
  'id' | 'isPending' | 'isQueue' | 'isReject' | 'isAbsent' | 'isCancel' | 'isRecall' | 'isCompleted' | 'isTimeout' | 'reset'
>;

type TokenIssuedFormGroupContent = {
  id: FormControl<ITokenIssued['id'] | NewTokenIssued['id']>;
  uid: FormControl<ITokenIssued['uid']>;
  profileBizId: FormControl<ITokenIssued['profileBizId']>;
  phoneNumber: FormControl<ITokenIssued['phoneNumber']>;
  phoneIsoCode: FormControl<ITokenIssued['phoneIsoCode']>;
  phoneCode: FormControl<ITokenIssued['phoneCode']>;
  userEmail: FormControl<ITokenIssued['userEmail']>;
  userFirstName: FormControl<ITokenIssued['userFirstName']>;
  userLastName: FormControl<ITokenIssued['userLastName']>;
  tokenLetter: FormControl<ITokenIssued['tokenLetter']>;
  tokenNumber: FormControl<ITokenIssued['tokenNumber']>;
  serviceName: FormControl<ITokenIssued['serviceName']>;
  serviceId: FormControl<ITokenIssued['serviceId']>;
  terminalName: FormControl<ITokenIssued['terminalName']>;
  terminalId: FormControl<ITokenIssued['terminalId']>;
  orgTerminalName: FormControl<ITokenIssued['orgTerminalName']>;
  orgTerminalId: FormControl<ITokenIssued['orgTerminalId']>;
  statusName: FormControl<ITokenIssued['statusName']>;
  statusCode: FormControl<ITokenIssued['statusCode']>;
  isPending: FormControl<ITokenIssued['isPending']>;
  isQueue: FormControl<ITokenIssued['isQueue']>;
  isReject: FormControl<ITokenIssued['isReject']>;
  isAbsent: FormControl<ITokenIssued['isAbsent']>;
  isCancel: FormControl<ITokenIssued['isCancel']>;
  isRecall: FormControl<ITokenIssued['isRecall']>;
  isCompleted: FormControl<ITokenIssued['isCompleted']>;
  isTimeout: FormControl<ITokenIssued['isTimeout']>;
  assignedDate: FormControl<ITokenIssued['assignedDate']>;
  assignedYear: FormControl<ITokenIssued['assignedYear']>;
  assignedMonth: FormControl<ITokenIssued['assignedMonth']>;
  assignedDay: FormControl<ITokenIssued['assignedDay']>;
  assignedHour: FormControl<ITokenIssued['assignedHour']>;
  assignedMin: FormControl<ITokenIssued['assignedMin']>;
  assignedTimeZoneOffset: FormControl<ITokenIssued['assignedTimeZoneOffset']>;
  assignedTimeZoneName: FormControl<ITokenIssued['assignedTimeZoneName']>;
  assignedNow: FormControl<ITokenIssued['assignedNow']>;
  assignedUid: FormControl<ITokenIssued['assignedUid']>;
  completedYear: FormControl<ITokenIssued['completedYear']>;
  completedMonth: FormControl<ITokenIssued['completedMonth']>;
  completedDay: FormControl<ITokenIssued['completedDay']>;
  completedHour: FormControl<ITokenIssued['completedHour']>;
  completedMin: FormControl<ITokenIssued['completedMin']>;
  completedTimeZoneOffset: FormControl<ITokenIssued['completedTimeZoneOffset']>;
  completedTimeZoneName: FormControl<ITokenIssued['completedTimeZoneName']>;
  completedNow: FormControl<ITokenIssued['completedNow']>;
  completedDate: FormControl<ITokenIssued['completedDate']>;
  completedUid: FormControl<ITokenIssued['completedUid']>;
  createdYear: FormControl<ITokenIssued['createdYear']>;
  createdMonth: FormControl<ITokenIssued['createdMonth']>;
  createdDay: FormControl<ITokenIssued['createdDay']>;
  createdHour: FormControl<ITokenIssued['createdHour']>;
  createdMin: FormControl<ITokenIssued['createdMin']>;
  createdTimeZoneOffset: FormControl<ITokenIssued['createdTimeZoneOffset']>;
  createdTimeZoneName: FormControl<ITokenIssued['createdTimeZoneName']>;
  createdNow: FormControl<ITokenIssued['createdNow']>;
  createdDate: FormControl<ITokenIssued['createdDate']>;
  modifiedYear: FormControl<ITokenIssued['modifiedYear']>;
  modifiedMonth: FormControl<ITokenIssued['modifiedMonth']>;
  modifiedDay: FormControl<ITokenIssued['modifiedDay']>;
  modifiedHour: FormControl<ITokenIssued['modifiedHour']>;
  modifiedMin: FormControl<ITokenIssued['modifiedMin']>;
  modifiedTimeZoneOffset: FormControl<ITokenIssued['modifiedTimeZoneOffset']>;
  modifiedTimeZoneName: FormControl<ITokenIssued['modifiedTimeZoneName']>;
  modifiedNow: FormControl<ITokenIssued['modifiedNow']>;
  modifiedDate: FormControl<ITokenIssued['modifiedDate']>;
  transferedYear: FormControl<ITokenIssued['transferedYear']>;
  transferedMonth: FormControl<ITokenIssued['transferedMonth']>;
  transferedDay: FormControl<ITokenIssued['transferedDay']>;
  transferedHour: FormControl<ITokenIssued['transferedHour']>;
  transferedMin: FormControl<ITokenIssued['transferedMin']>;
  transferedDate: FormControl<ITokenIssued['transferedDate']>;
  transferedTimeZoneOffset: FormControl<ITokenIssued['transferedTimeZoneOffset']>;
  transferedTimeZoneName: FormControl<ITokenIssued['transferedTimeZoneName']>;
  transferedNow: FormControl<ITokenIssued['transferedNow']>;
  transferedUid: FormControl<ITokenIssued['transferedUid']>;
  issuedFrom: FormControl<ITokenIssued['issuedFrom']>;
  departmentId: FormControl<ITokenIssued['departmentId']>;
  departmentName: FormControl<ITokenIssued['departmentName']>;
  bizName: FormControl<ITokenIssued['bizName']>;
  rating: FormControl<ITokenIssued['rating']>;
  feedback: FormControl<ITokenIssued['feedback']>;
  smsComingCount: FormControl<ITokenIssued['smsComingCount']>;
  pushComingCount: FormControl<ITokenIssued['pushComingCount']>;
  orderId: FormControl<ITokenIssued['orderId']>;
  reset: FormControl<ITokenIssued['reset']>;
  resetDate: FormControl<ITokenIssued['resetDate']>;
  resetUid: FormControl<ITokenIssued['resetUid']>;
};

export type TokenIssuedFormGroup = FormGroup<TokenIssuedFormGroupContent>;

@Injectable({ providedIn: 'root' })
export class TokenIssuedFormService {
  createTokenIssuedFormGroup(tokenIssued: TokenIssuedFormGroupInput = { id: null }): TokenIssuedFormGroup {
    const tokenIssuedRawValue = {
      ...this.getFormDefaults(),
      ...tokenIssued,
    };
    return new FormGroup<TokenIssuedFormGroupContent>({
      id: new FormControl(
        { value: tokenIssuedRawValue.id, disabled: true },
        {
          nonNullable: true,
          validators: [Validators.required],
        },
      ),
      uid: new FormControl(tokenIssuedRawValue.uid, {
        validators: [Validators.required],
      }),
      profileBizId: new FormControl(tokenIssuedRawValue.profileBizId),
      phoneNumber: new FormControl(tokenIssuedRawValue.phoneNumber),
      phoneIsoCode: new FormControl(tokenIssuedRawValue.phoneIsoCode),
      phoneCode: new FormControl(tokenIssuedRawValue.phoneCode),
      userEmail: new FormControl(tokenIssuedRawValue.userEmail),
      userFirstName: new FormControl(tokenIssuedRawValue.userFirstName),
      userLastName: new FormControl(tokenIssuedRawValue.userLastName),
      tokenLetter: new FormControl(tokenIssuedRawValue.tokenLetter),
      tokenNumber: new FormControl(tokenIssuedRawValue.tokenNumber),
      serviceName: new FormControl(tokenIssuedRawValue.serviceName),
      serviceId: new FormControl(tokenIssuedRawValue.serviceId),
      terminalName: new FormControl(tokenIssuedRawValue.terminalName),
      terminalId: new FormControl(tokenIssuedRawValue.terminalId),
      orgTerminalName: new FormControl(tokenIssuedRawValue.orgTerminalName),
      orgTerminalId: new FormControl(tokenIssuedRawValue.orgTerminalId),
      statusName: new FormControl(tokenIssuedRawValue.statusName),
      statusCode: new FormControl(tokenIssuedRawValue.statusCode),
      isPending: new FormControl(tokenIssuedRawValue.isPending),
      isQueue: new FormControl(tokenIssuedRawValue.isQueue),
      isReject: new FormControl(tokenIssuedRawValue.isReject),
      isAbsent: new FormControl(tokenIssuedRawValue.isAbsent),
      isCancel: new FormControl(tokenIssuedRawValue.isCancel),
      isRecall: new FormControl(tokenIssuedRawValue.isRecall),
      isCompleted: new FormControl(tokenIssuedRawValue.isCompleted),
      isTimeout: new FormControl(tokenIssuedRawValue.isTimeout),
      assignedDate: new FormControl(tokenIssuedRawValue.assignedDate),
      assignedYear: new FormControl(tokenIssuedRawValue.assignedYear),
      assignedMonth: new FormControl(tokenIssuedRawValue.assignedMonth),
      assignedDay: new FormControl(tokenIssuedRawValue.assignedDay),
      assignedHour: new FormControl(tokenIssuedRawValue.assignedHour),
      assignedMin: new FormControl(tokenIssuedRawValue.assignedMin),
      assignedTimeZoneOffset: new FormControl(tokenIssuedRawValue.assignedTimeZoneOffset),
      assignedTimeZoneName: new FormControl(tokenIssuedRawValue.assignedTimeZoneName),
      assignedNow: new FormControl(tokenIssuedRawValue.assignedNow),
      assignedUid: new FormControl(tokenIssuedRawValue.assignedUid),
      completedYear: new FormControl(tokenIssuedRawValue.completedYear),
      completedMonth: new FormControl(tokenIssuedRawValue.completedMonth),
      completedDay: new FormControl(tokenIssuedRawValue.completedDay),
      completedHour: new FormControl(tokenIssuedRawValue.completedHour),
      completedMin: new FormControl(tokenIssuedRawValue.completedMin),
      completedTimeZoneOffset: new FormControl(tokenIssuedRawValue.completedTimeZoneOffset),
      completedTimeZoneName: new FormControl(tokenIssuedRawValue.completedTimeZoneName),
      completedNow: new FormControl(tokenIssuedRawValue.completedNow),
      completedDate: new FormControl(tokenIssuedRawValue.completedDate),
      completedUid: new FormControl(tokenIssuedRawValue.completedUid),
      createdYear: new FormControl(tokenIssuedRawValue.createdYear),
      createdMonth: new FormControl(tokenIssuedRawValue.createdMonth),
      createdDay: new FormControl(tokenIssuedRawValue.createdDay),
      createdHour: new FormControl(tokenIssuedRawValue.createdHour),
      createdMin: new FormControl(tokenIssuedRawValue.createdMin),
      createdTimeZoneOffset: new FormControl(tokenIssuedRawValue.createdTimeZoneOffset),
      createdTimeZoneName: new FormControl(tokenIssuedRawValue.createdTimeZoneName),
      createdNow: new FormControl(tokenIssuedRawValue.createdNow),
      createdDate: new FormControl(tokenIssuedRawValue.createdDate),
      modifiedYear: new FormControl(tokenIssuedRawValue.modifiedYear),
      modifiedMonth: new FormControl(tokenIssuedRawValue.modifiedMonth),
      modifiedDay: new FormControl(tokenIssuedRawValue.modifiedDay),
      modifiedHour: new FormControl(tokenIssuedRawValue.modifiedHour),
      modifiedMin: new FormControl(tokenIssuedRawValue.modifiedMin),
      modifiedTimeZoneOffset: new FormControl(tokenIssuedRawValue.modifiedTimeZoneOffset),
      modifiedTimeZoneName: new FormControl(tokenIssuedRawValue.modifiedTimeZoneName),
      modifiedNow: new FormControl(tokenIssuedRawValue.modifiedNow),
      modifiedDate: new FormControl(tokenIssuedRawValue.modifiedDate),
      transferedYear: new FormControl(tokenIssuedRawValue.transferedYear),
      transferedMonth: new FormControl(tokenIssuedRawValue.transferedMonth),
      transferedDay: new FormControl(tokenIssuedRawValue.transferedDay),
      transferedHour: new FormControl(tokenIssuedRawValue.transferedHour),
      transferedMin: new FormControl(tokenIssuedRawValue.transferedMin),
      transferedDate: new FormControl(tokenIssuedRawValue.transferedDate),
      transferedTimeZoneOffset: new FormControl(tokenIssuedRawValue.transferedTimeZoneOffset),
      transferedTimeZoneName: new FormControl(tokenIssuedRawValue.transferedTimeZoneName),
      transferedNow: new FormControl(tokenIssuedRawValue.transferedNow),
      transferedUid: new FormControl(tokenIssuedRawValue.transferedUid),
      issuedFrom: new FormControl(tokenIssuedRawValue.issuedFrom),
      departmentId: new FormControl(tokenIssuedRawValue.departmentId),
      departmentName: new FormControl(tokenIssuedRawValue.departmentName),
      bizName: new FormControl(tokenIssuedRawValue.bizName),
      rating: new FormControl(tokenIssuedRawValue.rating),
      feedback: new FormControl(tokenIssuedRawValue.feedback),
      smsComingCount: new FormControl(tokenIssuedRawValue.smsComingCount),
      pushComingCount: new FormControl(tokenIssuedRawValue.pushComingCount),
      orderId: new FormControl(tokenIssuedRawValue.orderId),
      reset: new FormControl(tokenIssuedRawValue.reset),
      resetDate: new FormControl(tokenIssuedRawValue.resetDate),
      resetUid: new FormControl(tokenIssuedRawValue.resetUid),
    });
  }

  getTokenIssued(form: TokenIssuedFormGroup): ITokenIssued | NewTokenIssued {
    return form.getRawValue() as ITokenIssued | NewTokenIssued;
  }

  resetForm(form: TokenIssuedFormGroup, tokenIssued: TokenIssuedFormGroupInput): void {
    const tokenIssuedRawValue = { ...this.getFormDefaults(), ...tokenIssued };
    form.reset(
      {
        ...tokenIssuedRawValue,
        id: { value: tokenIssuedRawValue.id, disabled: true },
      } as any /* cast to workaround https://github.com/angular/angular/issues/46458 */,
    );
  }

  private getFormDefaults(): TokenIssuedFormDefaults {
    return {
      id: null,
      isPending: false,
      isQueue: false,
      isReject: false,
      isAbsent: false,
      isCancel: false,
      isRecall: false,
      isCompleted: false,
      isTimeout: false,
      reset: false,
    };
  }
}
