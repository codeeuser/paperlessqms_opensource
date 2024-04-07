import { TestBed } from '@angular/core/testing';

import { sampleWithRequiredData, sampleWithNewData } from '../queue-service.test-samples';

import { QueueServiceFormService } from './queue-service-form.service';

describe('QueueService Form Service', () => {
  let service: QueueServiceFormService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(QueueServiceFormService);
  });

  describe('Service methods', () => {
    describe('createQueueServiceFormGroup', () => {
      it('should create a new form with FormControl', () => {
        const formGroup = service.createQueueServiceFormGroup();

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            profileBizId: expect.any(Object),
            name: expect.any(Object),
            type: expect.any(Object),
            letter: expect.any(Object),
            start: expect.any(Object),
            desc: expect.any(Object),
            enable: expect.any(Object),
            orderNum: expect.any(Object),
            enableCatalog: expect.any(Object),
            createdDate: expect.any(Object),
            modifiedDate: expect.any(Object),
            queueDepartment: expect.any(Object),
          }),
        );
      });

      it('passing IQueueService should create a new form with FormGroup', () => {
        const formGroup = service.createQueueServiceFormGroup(sampleWithRequiredData);

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            profileBizId: expect.any(Object),
            name: expect.any(Object),
            type: expect.any(Object),
            letter: expect.any(Object),
            start: expect.any(Object),
            desc: expect.any(Object),
            enable: expect.any(Object),
            orderNum: expect.any(Object),
            enableCatalog: expect.any(Object),
            createdDate: expect.any(Object),
            modifiedDate: expect.any(Object),
            queueDepartment: expect.any(Object),
          }),
        );
      });
    });

    describe('getQueueService', () => {
      it('should return NewQueueService for default QueueService initial value', () => {
        const formGroup = service.createQueueServiceFormGroup(sampleWithNewData);

        const queueService = service.getQueueService(formGroup) as any;

        expect(queueService).toMatchObject(sampleWithNewData);
      });

      it('should return NewQueueService for empty QueueService initial value', () => {
        const formGroup = service.createQueueServiceFormGroup();

        const queueService = service.getQueueService(formGroup) as any;

        expect(queueService).toMatchObject({});
      });

      it('should return IQueueService', () => {
        const formGroup = service.createQueueServiceFormGroup(sampleWithRequiredData);

        const queueService = service.getQueueService(formGroup) as any;

        expect(queueService).toMatchObject(sampleWithRequiredData);
      });
    });

    describe('resetForm', () => {
      it('passing IQueueService should not enable id FormControl', () => {
        const formGroup = service.createQueueServiceFormGroup();
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, sampleWithRequiredData);

        expect(formGroup.controls.id.disabled).toBe(true);
      });

      it('passing NewQueueService should disable id FormControl', () => {
        const formGroup = service.createQueueServiceFormGroup(sampleWithRequiredData);
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, { id: null });

        expect(formGroup.controls.id.disabled).toBe(true);
      });
    });
  });
});
