import { TestBed } from '@angular/core/testing';

import { sampleWithRequiredData, sampleWithNewData } from '../max-token.test-samples';

import { MaxTokenFormService } from './max-token-form.service';

describe('MaxToken Form Service', () => {
  let service: MaxTokenFormService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(MaxTokenFormService);
  });

  describe('Service methods', () => {
    describe('createMaxTokenFormGroup', () => {
      it('should create a new form with FormControl', () => {
        const formGroup = service.createMaxTokenFormGroup();

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            profileBizId: expect.any(Object),
            maxToken: expect.any(Object),
            dayNum: expect.any(Object),
            modifiedDate: expect.any(Object),
            createdDate: expect.any(Object),
          }),
        );
      });

      it('passing IMaxToken should create a new form with FormGroup', () => {
        const formGroup = service.createMaxTokenFormGroup(sampleWithRequiredData);

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            profileBizId: expect.any(Object),
            maxToken: expect.any(Object),
            dayNum: expect.any(Object),
            modifiedDate: expect.any(Object),
            createdDate: expect.any(Object),
          }),
        );
      });
    });

    describe('getMaxToken', () => {
      it('should return NewMaxToken for default MaxToken initial value', () => {
        const formGroup = service.createMaxTokenFormGroup(sampleWithNewData);

        const maxToken = service.getMaxToken(formGroup) as any;

        expect(maxToken).toMatchObject(sampleWithNewData);
      });

      it('should return NewMaxToken for empty MaxToken initial value', () => {
        const formGroup = service.createMaxTokenFormGroup();

        const maxToken = service.getMaxToken(formGroup) as any;

        expect(maxToken).toMatchObject({});
      });

      it('should return IMaxToken', () => {
        const formGroup = service.createMaxTokenFormGroup(sampleWithRequiredData);

        const maxToken = service.getMaxToken(formGroup) as any;

        expect(maxToken).toMatchObject(sampleWithRequiredData);
      });
    });

    describe('resetForm', () => {
      it('passing IMaxToken should not enable id FormControl', () => {
        const formGroup = service.createMaxTokenFormGroup();
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, sampleWithRequiredData);

        expect(formGroup.controls.id.disabled).toBe(true);
      });

      it('passing NewMaxToken should disable id FormControl', () => {
        const formGroup = service.createMaxTokenFormGroup(sampleWithRequiredData);
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, { id: null });

        expect(formGroup.controls.id.disabled).toBe(true);
      });
    });
  });
});
