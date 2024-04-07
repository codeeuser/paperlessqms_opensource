import { TestBed } from '@angular/core/testing';

import { sampleWithRequiredData, sampleWithNewData } from '../queue-department.test-samples';

import { QueueDepartmentFormService } from './queue-department-form.service';

describe('QueueDepartment Form Service', () => {
  let service: QueueDepartmentFormService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(QueueDepartmentFormService);
  });

  describe('Service methods', () => {
    describe('createQueueDepartmentFormGroup', () => {
      it('should create a new form with FormControl', () => {
        const formGroup = service.createQueueDepartmentFormGroup();

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            profileBizId: expect.any(Object),
            bizName: expect.any(Object),
            bizCategoryName: expect.any(Object),
            name: expect.any(Object),
            desc: expect.any(Object),
            lat: expect.any(Object),
            lng: expect.any(Object),
            timeZone: expect.any(Object),
            threshold: expect.any(Object),
            nearbyRange: expect.any(Object),
            tokenTimeoutMin: expect.any(Object),
            selected: expect.any(Object),
            enable: expect.any(Object),
            orderNum: expect.any(Object),
            currencySymbol: expect.any(Object),
            lenMetric: expect.any(Object),
            currencyCode: expect.any(Object),
            bannerName: expect.any(Object),
            createdDate: expect.any(Object),
            modifiedDate: expect.any(Object),
          }),
        );
      });

      it('passing IQueueDepartment should create a new form with FormGroup', () => {
        const formGroup = service.createQueueDepartmentFormGroup(sampleWithRequiredData);

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            profileBizId: expect.any(Object),
            bizName: expect.any(Object),
            bizCategoryName: expect.any(Object),
            name: expect.any(Object),
            desc: expect.any(Object),
            lat: expect.any(Object),
            lng: expect.any(Object),
            timeZone: expect.any(Object),
            threshold: expect.any(Object),
            nearbyRange: expect.any(Object),
            tokenTimeoutMin: expect.any(Object),
            selected: expect.any(Object),
            enable: expect.any(Object),
            orderNum: expect.any(Object),
            currencySymbol: expect.any(Object),
            lenMetric: expect.any(Object),
            currencyCode: expect.any(Object),
            bannerName: expect.any(Object),
            createdDate: expect.any(Object),
            modifiedDate: expect.any(Object),
          }),
        );
      });
    });

    describe('getQueueDepartment', () => {
      it('should return NewQueueDepartment for default QueueDepartment initial value', () => {
        const formGroup = service.createQueueDepartmentFormGroup(sampleWithNewData);

        const queueDepartment = service.getQueueDepartment(formGroup) as any;

        expect(queueDepartment).toMatchObject(sampleWithNewData);
      });

      it('should return NewQueueDepartment for empty QueueDepartment initial value', () => {
        const formGroup = service.createQueueDepartmentFormGroup();

        const queueDepartment = service.getQueueDepartment(formGroup) as any;

        expect(queueDepartment).toMatchObject({});
      });

      it('should return IQueueDepartment', () => {
        const formGroup = service.createQueueDepartmentFormGroup(sampleWithRequiredData);

        const queueDepartment = service.getQueueDepartment(formGroup) as any;

        expect(queueDepartment).toMatchObject(sampleWithRequiredData);
      });
    });

    describe('resetForm', () => {
      it('passing IQueueDepartment should not enable id FormControl', () => {
        const formGroup = service.createQueueDepartmentFormGroup();
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, sampleWithRequiredData);

        expect(formGroup.controls.id.disabled).toBe(true);
      });

      it('passing NewQueueDepartment should disable id FormControl', () => {
        const formGroup = service.createQueueDepartmentFormGroup(sampleWithRequiredData);
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, { id: null });

        expect(formGroup.controls.id.disabled).toBe(true);
      });
    });
  });
});
