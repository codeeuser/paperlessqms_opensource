import { ComponentFixture, TestBed } from '@angular/core/testing';
import { HttpResponse } from '@angular/common/http';
import { HttpClientTestingModule } from '@angular/common/http/testing';
import { FormBuilder } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { RouterTestingModule } from '@angular/router/testing';
import { of, Subject, from } from 'rxjs';

import { IQueueTerminal } from 'app/entities/queue-terminal/queue-terminal.model';
import { QueueTerminalService } from 'app/entities/queue-terminal/service/queue-terminal.service';
import { IQueueDepartment } from 'app/entities/queue-department/queue-department.model';
import { QueueDepartmentService } from 'app/entities/queue-department/service/queue-department.service';
import { IAgent } from '../agent.model';
import { AgentService } from '../service/agent.service';
import { AgentFormService } from './agent-form.service';

import { AgentUpdateComponent } from './agent-update.component';

describe('Agent Management Update Component', () => {
  let comp: AgentUpdateComponent;
  let fixture: ComponentFixture<AgentUpdateComponent>;
  let activatedRoute: ActivatedRoute;
  let agentFormService: AgentFormService;
  let agentService: AgentService;
  let queueTerminalService: QueueTerminalService;
  let queueDepartmentService: QueueDepartmentService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule, RouterTestingModule.withRoutes([]), AgentUpdateComponent],
      providers: [
        FormBuilder,
        {
          provide: ActivatedRoute,
          useValue: {
            params: from([{}]),
          },
        },
      ],
    })
      .overrideTemplate(AgentUpdateComponent, '')
      .compileComponents();

    fixture = TestBed.createComponent(AgentUpdateComponent);
    activatedRoute = TestBed.inject(ActivatedRoute);
    agentFormService = TestBed.inject(AgentFormService);
    agentService = TestBed.inject(AgentService);
    queueTerminalService = TestBed.inject(QueueTerminalService);
    queueDepartmentService = TestBed.inject(QueueDepartmentService);

    comp = fixture.componentInstance;
  });

  describe('ngOnInit', () => {
    it('Should call QueueTerminal query and add missing value', () => {
      const agent: IAgent = { id: 456 };
      const queueTerminal: IQueueTerminal = { id: 14905 };
      agent.queueTerminal = queueTerminal;

      const queueTerminalCollection: IQueueTerminal[] = [{ id: 724 }];
      jest.spyOn(queueTerminalService, 'query').mockReturnValue(of(new HttpResponse({ body: queueTerminalCollection })));
      const additionalQueueTerminals = [queueTerminal];
      const expectedCollection: IQueueTerminal[] = [...additionalQueueTerminals, ...queueTerminalCollection];
      jest.spyOn(queueTerminalService, 'addQueueTerminalToCollectionIfMissing').mockReturnValue(expectedCollection);

      activatedRoute.data = of({ agent });
      comp.ngOnInit();

      expect(queueTerminalService.query).toHaveBeenCalled();
      expect(queueTerminalService.addQueueTerminalToCollectionIfMissing).toHaveBeenCalledWith(
        queueTerminalCollection,
        ...additionalQueueTerminals.map(expect.objectContaining),
      );
      expect(comp.queueTerminalsSharedCollection).toEqual(expectedCollection);
    });

    it('Should call QueueDepartment query and add missing value', () => {
      const agent: IAgent = { id: 456 };
      const queueDepartment: IQueueDepartment = { id: 13479 };
      agent.queueDepartment = queueDepartment;

      const queueDepartmentCollection: IQueueDepartment[] = [{ id: 7231 }];
      jest.spyOn(queueDepartmentService, 'query').mockReturnValue(of(new HttpResponse({ body: queueDepartmentCollection })));
      const additionalQueueDepartments = [queueDepartment];
      const expectedCollection: IQueueDepartment[] = [...additionalQueueDepartments, ...queueDepartmentCollection];
      jest.spyOn(queueDepartmentService, 'addQueueDepartmentToCollectionIfMissing').mockReturnValue(expectedCollection);

      activatedRoute.data = of({ agent });
      comp.ngOnInit();

      expect(queueDepartmentService.query).toHaveBeenCalled();
      expect(queueDepartmentService.addQueueDepartmentToCollectionIfMissing).toHaveBeenCalledWith(
        queueDepartmentCollection,
        ...additionalQueueDepartments.map(expect.objectContaining),
      );
      expect(comp.queueDepartmentsSharedCollection).toEqual(expectedCollection);
    });

    it('Should update editForm', () => {
      const agent: IAgent = { id: 456 };
      const queueTerminal: IQueueTerminal = { id: 1583 };
      agent.queueTerminal = queueTerminal;
      const queueDepartment: IQueueDepartment = { id: 8906 };
      agent.queueDepartment = queueDepartment;

      activatedRoute.data = of({ agent });
      comp.ngOnInit();

      expect(comp.queueTerminalsSharedCollection).toContain(queueTerminal);
      expect(comp.queueDepartmentsSharedCollection).toContain(queueDepartment);
      expect(comp.agent).toEqual(agent);
    });
  });

  describe('save', () => {
    it('Should call update service on save for existing entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IAgent>>();
      const agent = { id: 123 };
      jest.spyOn(agentFormService, 'getAgent').mockReturnValue(agent);
      jest.spyOn(agentService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ agent });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: agent }));
      saveSubject.complete();

      // THEN
      expect(agentFormService.getAgent).toHaveBeenCalled();
      expect(comp.previousState).toHaveBeenCalled();
      expect(agentService.update).toHaveBeenCalledWith(expect.objectContaining(agent));
      expect(comp.isSaving).toEqual(false);
    });

    it('Should call create service on save for new entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IAgent>>();
      const agent = { id: 123 };
      jest.spyOn(agentFormService, 'getAgent').mockReturnValue({ id: null });
      jest.spyOn(agentService, 'create').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ agent: null });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: agent }));
      saveSubject.complete();

      // THEN
      expect(agentFormService.getAgent).toHaveBeenCalled();
      expect(agentService.create).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).toHaveBeenCalled();
    });

    it('Should set isSaving to false on error', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IAgent>>();
      const agent = { id: 123 };
      jest.spyOn(agentService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ agent });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.error('This is an error!');

      // THEN
      expect(agentService.update).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).not.toHaveBeenCalled();
    });
  });

  describe('Compare relationships', () => {
    describe('compareQueueTerminal', () => {
      it('Should forward to queueTerminalService', () => {
        const entity = { id: 123 };
        const entity2 = { id: 456 };
        jest.spyOn(queueTerminalService, 'compareQueueTerminal');
        comp.compareQueueTerminal(entity, entity2);
        expect(queueTerminalService.compareQueueTerminal).toHaveBeenCalledWith(entity, entity2);
      });
    });

    describe('compareQueueDepartment', () => {
      it('Should forward to queueDepartmentService', () => {
        const entity = { id: 123 };
        const entity2 = { id: 456 };
        jest.spyOn(queueDepartmentService, 'compareQueueDepartment');
        comp.compareQueueDepartment(entity, entity2);
        expect(queueDepartmentService.compareQueueDepartment).toHaveBeenCalledWith(entity, entity2);
      });
    });
  });
});
