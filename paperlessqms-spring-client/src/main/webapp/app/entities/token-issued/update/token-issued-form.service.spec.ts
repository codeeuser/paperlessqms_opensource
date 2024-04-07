import { TestBed } from '@angular/core/testing';

import { sampleWithRequiredData, sampleWithNewData } from '../token-issued.test-samples';

import { TokenIssuedFormService } from './token-issued-form.service';

describe('TokenIssued Form Service', () => {
  let service: TokenIssuedFormService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(TokenIssuedFormService);
  });

  describe('Service methods', () => {
    describe('createTokenIssuedFormGroup', () => {
      it('should create a new form with FormControl', () => {
        const formGroup = service.createTokenIssuedFormGroup();

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            uid: expect.any(Object),
            profileBizId: expect.any(Object),
            phoneNumber: expect.any(Object),
            phoneIsoCode: expect.any(Object),
            phoneCode: expect.any(Object),
            userEmail: expect.any(Object),
            userFirstName: expect.any(Object),
            userLastName: expect.any(Object),
            tokenLetter: expect.any(Object),
            tokenNumber: expect.any(Object),
            serviceName: expect.any(Object),
            serviceId: expect.any(Object),
            terminalName: expect.any(Object),
            terminalId: expect.any(Object),
            orgTerminalName: expect.any(Object),
            orgTerminalId: expect.any(Object),
            statusName: expect.any(Object),
            statusCode: expect.any(Object),
            isPending: expect.any(Object),
            isQueue: expect.any(Object),
            isReject: expect.any(Object),
            isAbsent: expect.any(Object),
            isCancel: expect.any(Object),
            isRecall: expect.any(Object),
            isCompleted: expect.any(Object),
            isTimeout: expect.any(Object),
            assignedDate: expect.any(Object),
            assignedYear: expect.any(Object),
            assignedMonth: expect.any(Object),
            assignedDay: expect.any(Object),
            assignedHour: expect.any(Object),
            assignedMin: expect.any(Object),
            assignedTimeZoneOffset: expect.any(Object),
            assignedTimeZoneName: expect.any(Object),
            assignedNow: expect.any(Object),
            assignedUid: expect.any(Object),
            completedYear: expect.any(Object),
            completedMonth: expect.any(Object),
            completedDay: expect.any(Object),
            completedHour: expect.any(Object),
            completedMin: expect.any(Object),
            completedTimeZoneOffset: expect.any(Object),
            completedTimeZoneName: expect.any(Object),
            completedNow: expect.any(Object),
            completedDate: expect.any(Object),
            completedUid: expect.any(Object),
            createdYear: expect.any(Object),
            createdMonth: expect.any(Object),
            createdDay: expect.any(Object),
            createdHour: expect.any(Object),
            createdMin: expect.any(Object),
            createdTimeZoneOffset: expect.any(Object),
            createdTimeZoneName: expect.any(Object),
            createdNow: expect.any(Object),
            createdDate: expect.any(Object),
            modifiedYear: expect.any(Object),
            modifiedMonth: expect.any(Object),
            modifiedDay: expect.any(Object),
            modifiedHour: expect.any(Object),
            modifiedMin: expect.any(Object),
            modifiedTimeZoneOffset: expect.any(Object),
            modifiedTimeZoneName: expect.any(Object),
            modifiedNow: expect.any(Object),
            modifiedDate: expect.any(Object),
            transferedYear: expect.any(Object),
            transferedMonth: expect.any(Object),
            transferedDay: expect.any(Object),
            transferedHour: expect.any(Object),
            transferedMin: expect.any(Object),
            transferedDate: expect.any(Object),
            transferedTimeZoneOffset: expect.any(Object),
            transferedTimeZoneName: expect.any(Object),
            transferedNow: expect.any(Object),
            transferedUid: expect.any(Object),
            issuedFrom: expect.any(Object),
            departmentId: expect.any(Object),
            departmentName: expect.any(Object),
            bizName: expect.any(Object),
            rating: expect.any(Object),
            feedback: expect.any(Object),
            smsComingCount: expect.any(Object),
            pushComingCount: expect.any(Object),
            orderId: expect.any(Object),
            reset: expect.any(Object),
            resetDate: expect.any(Object),
            resetUid: expect.any(Object),
          }),
        );
      });

      it('passing ITokenIssued should create a new form with FormGroup', () => {
        const formGroup = service.createTokenIssuedFormGroup(sampleWithRequiredData);

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            uid: expect.any(Object),
            profileBizId: expect.any(Object),
            phoneNumber: expect.any(Object),
            phoneIsoCode: expect.any(Object),
            phoneCode: expect.any(Object),
            userEmail: expect.any(Object),
            userFirstName: expect.any(Object),
            userLastName: expect.any(Object),
            tokenLetter: expect.any(Object),
            tokenNumber: expect.any(Object),
            serviceName: expect.any(Object),
            serviceId: expect.any(Object),
            terminalName: expect.any(Object),
            terminalId: expect.any(Object),
            orgTerminalName: expect.any(Object),
            orgTerminalId: expect.any(Object),
            statusName: expect.any(Object),
            statusCode: expect.any(Object),
            isPending: expect.any(Object),
            isQueue: expect.any(Object),
            isReject: expect.any(Object),
            isAbsent: expect.any(Object),
            isCancel: expect.any(Object),
            isRecall: expect.any(Object),
            isCompleted: expect.any(Object),
            isTimeout: expect.any(Object),
            assignedDate: expect.any(Object),
            assignedYear: expect.any(Object),
            assignedMonth: expect.any(Object),
            assignedDay: expect.any(Object),
            assignedHour: expect.any(Object),
            assignedMin: expect.any(Object),
            assignedTimeZoneOffset: expect.any(Object),
            assignedTimeZoneName: expect.any(Object),
            assignedNow: expect.any(Object),
            assignedUid: expect.any(Object),
            completedYear: expect.any(Object),
            completedMonth: expect.any(Object),
            completedDay: expect.any(Object),
            completedHour: expect.any(Object),
            completedMin: expect.any(Object),
            completedTimeZoneOffset: expect.any(Object),
            completedTimeZoneName: expect.any(Object),
            completedNow: expect.any(Object),
            completedDate: expect.any(Object),
            completedUid: expect.any(Object),
            createdYear: expect.any(Object),
            createdMonth: expect.any(Object),
            createdDay: expect.any(Object),
            createdHour: expect.any(Object),
            createdMin: expect.any(Object),
            createdTimeZoneOffset: expect.any(Object),
            createdTimeZoneName: expect.any(Object),
            createdNow: expect.any(Object),
            createdDate: expect.any(Object),
            modifiedYear: expect.any(Object),
            modifiedMonth: expect.any(Object),
            modifiedDay: expect.any(Object),
            modifiedHour: expect.any(Object),
            modifiedMin: expect.any(Object),
            modifiedTimeZoneOffset: expect.any(Object),
            modifiedTimeZoneName: expect.any(Object),
            modifiedNow: expect.any(Object),
            modifiedDate: expect.any(Object),
            transferedYear: expect.any(Object),
            transferedMonth: expect.any(Object),
            transferedDay: expect.any(Object),
            transferedHour: expect.any(Object),
            transferedMin: expect.any(Object),
            transferedDate: expect.any(Object),
            transferedTimeZoneOffset: expect.any(Object),
            transferedTimeZoneName: expect.any(Object),
            transferedNow: expect.any(Object),
            transferedUid: expect.any(Object),
            issuedFrom: expect.any(Object),
            departmentId: expect.any(Object),
            departmentName: expect.any(Object),
            bizName: expect.any(Object),
            rating: expect.any(Object),
            feedback: expect.any(Object),
            smsComingCount: expect.any(Object),
            pushComingCount: expect.any(Object),
            orderId: expect.any(Object),
            reset: expect.any(Object),
            resetDate: expect.any(Object),
            resetUid: expect.any(Object),
          }),
        );
      });
    });

    describe('getTokenIssued', () => {
      it('should return NewTokenIssued for default TokenIssued initial value', () => {
        const formGroup = service.createTokenIssuedFormGroup(sampleWithNewData);

        const tokenIssued = service.getTokenIssued(formGroup) as any;

        expect(tokenIssued).toMatchObject(sampleWithNewData);
      });

      it('should return NewTokenIssued for empty TokenIssued initial value', () => {
        const formGroup = service.createTokenIssuedFormGroup();

        const tokenIssued = service.getTokenIssued(formGroup) as any;

        expect(tokenIssued).toMatchObject({});
      });

      it('should return ITokenIssued', () => {
        const formGroup = service.createTokenIssuedFormGroup(sampleWithRequiredData);

        const tokenIssued = service.getTokenIssued(formGroup) as any;

        expect(tokenIssued).toMatchObject(sampleWithRequiredData);
      });
    });

    describe('resetForm', () => {
      it('passing ITokenIssued should not enable id FormControl', () => {
        const formGroup = service.createTokenIssuedFormGroup();
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, sampleWithRequiredData);

        expect(formGroup.controls.id.disabled).toBe(true);
      });

      it('passing NewTokenIssued should disable id FormControl', () => {
        const formGroup = service.createTokenIssuedFormGroup(sampleWithRequiredData);
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, { id: null });

        expect(formGroup.controls.id.disabled).toBe(true);
      });
    });
  });
});
