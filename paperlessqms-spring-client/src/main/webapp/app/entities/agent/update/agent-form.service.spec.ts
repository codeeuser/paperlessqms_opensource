import { TestBed } from '@angular/core/testing';

import { sampleWithRequiredData, sampleWithNewData } from '../agent.test-samples';

import { AgentFormService } from './agent-form.service';

describe('Agent Form Service', () => {
  let service: AgentFormService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(AgentFormService);
  });

  describe('Service methods', () => {
    describe('createAgentFormGroup', () => {
      it('should create a new form with FormControl', () => {
        const formGroup = service.createAgentFormGroup();

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            profileBizId: expect.any(Object),
            uid: expect.any(Object),
            login: expect.any(Object),
            email: expect.any(Object),
            updateUid: expect.any(Object),
            enable: expect.any(Object),
            orderNum: expect.any(Object),
            createdDate: expect.any(Object),
            modifiedDate: expect.any(Object),
            queueTerminal: expect.any(Object),
            queueDepartment: expect.any(Object),
          }),
        );
      });

      it('passing IAgent should create a new form with FormGroup', () => {
        const formGroup = service.createAgentFormGroup(sampleWithRequiredData);

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            profileBizId: expect.any(Object),
            uid: expect.any(Object),
            login: expect.any(Object),
            email: expect.any(Object),
            updateUid: expect.any(Object),
            enable: expect.any(Object),
            orderNum: expect.any(Object),
            createdDate: expect.any(Object),
            modifiedDate: expect.any(Object),
            queueTerminal: expect.any(Object),
            queueDepartment: expect.any(Object),
          }),
        );
      });
    });

    describe('getAgent', () => {
      it('should return NewAgent for default Agent initial value', () => {
        const formGroup = service.createAgentFormGroup(sampleWithNewData);

        const agent = service.getAgent(formGroup) as any;

        expect(agent).toMatchObject(sampleWithNewData);
      });

      it('should return NewAgent for empty Agent initial value', () => {
        const formGroup = service.createAgentFormGroup();

        const agent = service.getAgent(formGroup) as any;

        expect(agent).toMatchObject({});
      });

      it('should return IAgent', () => {
        const formGroup = service.createAgentFormGroup(sampleWithRequiredData);

        const agent = service.getAgent(formGroup) as any;

        expect(agent).toMatchObject(sampleWithRequiredData);
      });
    });

    describe('resetForm', () => {
      it('passing IAgent should not enable id FormControl', () => {
        const formGroup = service.createAgentFormGroup();
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, sampleWithRequiredData);

        expect(formGroup.controls.id.disabled).toBe(true);
      });

      it('passing NewAgent should disable id FormControl', () => {
        const formGroup = service.createAgentFormGroup(sampleWithRequiredData);
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, { id: null });

        expect(formGroup.controls.id.disabled).toBe(true);
      });
    });
  });
});
