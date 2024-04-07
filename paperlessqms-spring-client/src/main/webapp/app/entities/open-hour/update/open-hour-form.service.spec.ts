import { TestBed } from '@angular/core/testing';

import { sampleWithRequiredData, sampleWithNewData } from '../open-hour.test-samples';

import { OpenHourFormService } from './open-hour-form.service';

describe('OpenHour Form Service', () => {
  let service: OpenHourFormService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(OpenHourFormService);
  });

  describe('Service methods', () => {
    describe('createOpenHourFormGroup', () => {
      it('should create a new form with FormControl', () => {
        const formGroup = service.createOpenHourFormGroup();

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            profileBizId: expect.any(Object),
            startHour: expect.any(Object),
            startMin: expect.any(Object),
            endHour: expect.any(Object),
            endMin: expect.any(Object),
            dayNum: expect.any(Object),
            enable: expect.any(Object),
            modifiedDate: expect.any(Object),
            createdDate: expect.any(Object),
          }),
        );
      });

      it('passing IOpenHour should create a new form with FormGroup', () => {
        const formGroup = service.createOpenHourFormGroup(sampleWithRequiredData);

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            profileBizId: expect.any(Object),
            startHour: expect.any(Object),
            startMin: expect.any(Object),
            endHour: expect.any(Object),
            endMin: expect.any(Object),
            dayNum: expect.any(Object),
            enable: expect.any(Object),
            modifiedDate: expect.any(Object),
            createdDate: expect.any(Object),
          }),
        );
      });
    });

    describe('getOpenHour', () => {
      it('should return NewOpenHour for default OpenHour initial value', () => {
        const formGroup = service.createOpenHourFormGroup(sampleWithNewData);

        const openHour = service.getOpenHour(formGroup) as any;

        expect(openHour).toMatchObject(sampleWithNewData);
      });

      it('should return NewOpenHour for empty OpenHour initial value', () => {
        const formGroup = service.createOpenHourFormGroup();

        const openHour = service.getOpenHour(formGroup) as any;

        expect(openHour).toMatchObject({});
      });

      it('should return IOpenHour', () => {
        const formGroup = service.createOpenHourFormGroup(sampleWithRequiredData);

        const openHour = service.getOpenHour(formGroup) as any;

        expect(openHour).toMatchObject(sampleWithRequiredData);
      });
    });

    describe('resetForm', () => {
      it('passing IOpenHour should not enable id FormControl', () => {
        const formGroup = service.createOpenHourFormGroup();
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, sampleWithRequiredData);

        expect(formGroup.controls.id.disabled).toBe(true);
      });

      it('passing NewOpenHour should disable id FormControl', () => {
        const formGroup = service.createOpenHourFormGroup(sampleWithRequiredData);
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, { id: null });

        expect(formGroup.controls.id.disabled).toBe(true);
      });
    });
  });
});
