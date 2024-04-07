import { TestBed } from '@angular/core/testing';

import { sampleWithRequiredData, sampleWithNewData } from '../token-number.test-samples';

import { TokenNumberFormService } from './token-number-form.service';

describe('TokenNumber Form Service', () => {
  let service: TokenNumberFormService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(TokenNumberFormService);
  });

  describe('Service methods', () => {
    describe('createTokenNumberFormGroup', () => {
      it('should create a new form with FormControl', () => {
        const formGroup = service.createTokenNumberFormGroup();

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            number: expect.any(Object),
            departmentId: expect.any(Object),
            serviceId: expect.any(Object),
            reset: expect.any(Object),
          }),
        );
      });

      it('passing ITokenNumber should create a new form with FormGroup', () => {
        const formGroup = service.createTokenNumberFormGroup(sampleWithRequiredData);

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            number: expect.any(Object),
            departmentId: expect.any(Object),
            serviceId: expect.any(Object),
            reset: expect.any(Object),
          }),
        );
      });
    });

    describe('getTokenNumber', () => {
      it('should return NewTokenNumber for default TokenNumber initial value', () => {
        const formGroup = service.createTokenNumberFormGroup(sampleWithNewData);

        const tokenNumber = service.getTokenNumber(formGroup) as any;

        expect(tokenNumber).toMatchObject(sampleWithNewData);
      });

      it('should return NewTokenNumber for empty TokenNumber initial value', () => {
        const formGroup = service.createTokenNumberFormGroup();

        const tokenNumber = service.getTokenNumber(formGroup) as any;

        expect(tokenNumber).toMatchObject({});
      });

      it('should return ITokenNumber', () => {
        const formGroup = service.createTokenNumberFormGroup(sampleWithRequiredData);

        const tokenNumber = service.getTokenNumber(formGroup) as any;

        expect(tokenNumber).toMatchObject(sampleWithRequiredData);
      });
    });

    describe('resetForm', () => {
      it('passing ITokenNumber should not enable id FormControl', () => {
        const formGroup = service.createTokenNumberFormGroup();
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, sampleWithRequiredData);

        expect(formGroup.controls.id.disabled).toBe(true);
      });

      it('passing NewTokenNumber should disable id FormControl', () => {
        const formGroup = service.createTokenNumberFormGroup(sampleWithRequiredData);
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, { id: null });

        expect(formGroup.controls.id.disabled).toBe(true);
      });
    });
  });
});
