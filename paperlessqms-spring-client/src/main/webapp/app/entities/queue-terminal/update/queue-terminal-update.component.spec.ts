import { ComponentFixture, TestBed } from '@angular/core/testing';
import { HttpResponse } from '@angular/common/http';
import { HttpClientTestingModule } from '@angular/common/http/testing';
import { FormBuilder } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { RouterTestingModule } from '@angular/router/testing';
import { of, Subject, from } from 'rxjs';

import { IQueueDepartment } from 'app/entities/queue-department/queue-department.model';
import { QueueDepartmentService } from 'app/entities/queue-department/service/queue-department.service';
import { QueueTerminalService } from '../service/queue-terminal.service';
import { IQueueTerminal } from '../queue-terminal.model';
import { QueueTerminalFormService } from './queue-terminal-form.service';

import { QueueTerminalUpdateComponent } from './queue-terminal-update.component';

describe('QueueTerminal Management Update Component', () => {
  let comp: QueueTerminalUpdateComponent;
  let fixture: ComponentFixture<QueueTerminalUpdateComponent>;
  let activatedRoute: ActivatedRoute;
  let queueTerminalFormService: QueueTerminalFormService;
  let queueTerminalService: QueueTerminalService;
  let queueDepartmentService: QueueDepartmentService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule, RouterTestingModule.withRoutes([]), QueueTerminalUpdateComponent],
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
      .overrideTemplate(QueueTerminalUpdateComponent, '')
      .compileComponents();

    fixture = TestBed.createComponent(QueueTerminalUpdateComponent);
    activatedRoute = TestBed.inject(ActivatedRoute);
    queueTerminalFormService = TestBed.inject(QueueTerminalFormService);
    queueTerminalService = TestBed.inject(QueueTerminalService);
    queueDepartmentService = TestBed.inject(QueueDepartmentService);

    comp = fixture.componentInstance;
  });

  describe('ngOnInit', () => {
    it('Should call QueueDepartment query and add missing value', () => {
      const queueTerminal: IQueueTerminal = { id: 456 };
      const queueDepartment: IQueueDepartment = { id: 22911 };
      queueTerminal.queueDepartment = queueDepartment;

      const queueDepartmentCollection: IQueueDepartment[] = [{ id: 1383 }];
      jest.spyOn(queueDepartmentService, 'query').mockReturnValue(of(new HttpResponse({ body: queueDepartmentCollection })));
      const additionalQueueDepartments = [queueDepartment];
      const expectedCollection: IQueueDepartment[] = [...additionalQueueDepartments, ...queueDepartmentCollection];
      jest.spyOn(queueDepartmentService, 'addQueueDepartmentToCollectionIfMissing').mockReturnValue(expectedCollection);

      activatedRoute.data = of({ queueTerminal });
      comp.ngOnInit();

      expect(queueDepartmentService.query).toHaveBeenCalled();
      expect(queueDepartmentService.addQueueDepartmentToCollectionIfMissing).toHaveBeenCalledWith(
        queueDepartmentCollection,
        ...additionalQueueDepartments.map(expect.objectContaining),
      );
      expect(comp.queueDepartmentsSharedCollection).toEqual(expectedCollection);
    });

    it('Should update editForm', () => {
      const queueTerminal: IQueueTerminal = { id: 456 };
      const queueDepartment: IQueueDepartment = { id: 20758 };
      queueTerminal.queueDepartment = queueDepartment;

      activatedRoute.data = of({ queueTerminal });
      comp.ngOnInit();

      expect(comp.queueDepartmentsSharedCollection).toContain(queueDepartment);
      expect(comp.queueTerminal).toEqual(queueTerminal);
    });
  });

  describe('save', () => {
    it('Should call update service on save for existing entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IQueueTerminal>>();
      const queueTerminal = { id: 123 };
      jest.spyOn(queueTerminalFormService, 'getQueueTerminal').mockReturnValue(queueTerminal);
      jest.spyOn(queueTerminalService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ queueTerminal });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: queueTerminal }));
      saveSubject.complete();

      // THEN
      expect(queueTerminalFormService.getQueueTerminal).toHaveBeenCalled();
      expect(comp.previousState).toHaveBeenCalled();
      expect(queueTerminalService.update).toHaveBeenCalledWith(expect.objectContaining(queueTerminal));
      expect(comp.isSaving).toEqual(false);
    });

    it('Should call create service on save for new entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IQueueTerminal>>();
      const queueTerminal = { id: 123 };
      jest.spyOn(queueTerminalFormService, 'getQueueTerminal').mockReturnValue({ id: null });
      jest.spyOn(queueTerminalService, 'create').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ queueTerminal: null });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: queueTerminal }));
      saveSubject.complete();

      // THEN
      expect(queueTerminalFormService.getQueueTerminal).toHaveBeenCalled();
      expect(queueTerminalService.create).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).toHaveBeenCalled();
    });

    it('Should set isSaving to false on error', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IQueueTerminal>>();
      const queueTerminal = { id: 123 };
      jest.spyOn(queueTerminalService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ queueTerminal });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.error('This is an error!');

      // THEN
      expect(queueTerminalService.update).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).not.toHaveBeenCalled();
    });
  });

  describe('Compare relationships', () => {
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
