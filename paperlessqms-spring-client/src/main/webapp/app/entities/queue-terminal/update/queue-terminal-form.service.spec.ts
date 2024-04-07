import { TestBed } from '@angular/core/testing';

import { sampleWithRequiredData, sampleWithNewData } from '../queue-terminal.test-samples';

import { QueueTerminalFormService } from './queue-terminal-form.service';

describe('QueueTerminal Form Service', () => {
  let service: QueueTerminalFormService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(QueueTerminalFormService);
  });

  describe('Service methods', () => {
    describe('createQueueTerminalFormGroup', () => {
      it('should create a new form with FormControl', () => {
        const formGroup = service.createQueueTerminalFormGroup();

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            profileBizId: expect.any(Object),
            name: expect.any(Object),
            enable: expect.any(Object),
            orderNum: expect.any(Object),
            createdDate: expect.any(Object),
            modifiedDate: expect.any(Object),
            queueDepartment: expect.any(Object),
          }),
        );
      });

      it('passing IQueueTerminal should create a new form with FormGroup', () => {
        const formGroup = service.createQueueTerminalFormGroup(sampleWithRequiredData);

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            profileBizId: expect.any(Object),
            name: expect.any(Object),
            enable: expect.any(Object),
            orderNum: expect.any(Object),
            createdDate: expect.any(Object),
            modifiedDate: expect.any(Object),
            queueDepartment: expect.any(Object),
          }),
        );
      });
    });

    describe('getQueueTerminal', () => {
      it('should return NewQueueTerminal for default QueueTerminal initial value', () => {
        const formGroup = service.createQueueTerminalFormGroup(sampleWithNewData);

        const queueTerminal = service.getQueueTerminal(formGroup) as any;

        expect(queueTerminal).toMatchObject(sampleWithNewData);
      });

      it('should return NewQueueTerminal for empty QueueTerminal initial value', () => {
        const formGroup = service.createQueueTerminalFormGroup();

        const queueTerminal = service.getQueueTerminal(formGroup) as any;

        expect(queueTerminal).toMatchObject({});
      });

      it('should return IQueueTerminal', () => {
        const formGroup = service.createQueueTerminalFormGroup(sampleWithRequiredData);

        const queueTerminal = service.getQueueTerminal(formGroup) as any;

        expect(queueTerminal).toMatchObject(sampleWithRequiredData);
      });
    });

    describe('resetForm', () => {
      it('passing IQueueTerminal should not enable id FormControl', () => {
        const formGroup = service.createQueueTerminalFormGroup();
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, sampleWithRequiredData);

        expect(formGroup.controls.id.disabled).toBe(true);
      });

      it('passing NewQueueTerminal should disable id FormControl', () => {
        const formGroup = service.createQueueTerminalFormGroup(sampleWithRequiredData);
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, { id: null });

        expect(formGroup.controls.id.disabled).toBe(true);
      });
    });
  });
});
