import { ComponentFixture, TestBed } from '@angular/core/testing';
import { HttpResponse } from '@angular/common/http';
import { HttpClientTestingModule } from '@angular/common/http/testing';
import { FormBuilder } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { RouterTestingModule } from '@angular/router/testing';
import { of, Subject, from } from 'rxjs';

import { IQueueDepartment } from 'app/entities/queue-department/queue-department.model';
import { QueueDepartmentService } from 'app/entities/queue-department/service/queue-department.service';
import { QueueServiceService } from '../service/queue-service.service';
import { IQueueService } from '../queue-service.model';
import { QueueServiceFormService } from './queue-service-form.service';

import { QueueServiceUpdateComponent } from './queue-service-update.component';

describe('QueueService Management Update Component', () => {
  let comp: QueueServiceUpdateComponent;
  let fixture: ComponentFixture<QueueServiceUpdateComponent>;
  let activatedRoute: ActivatedRoute;
  let queueServiceFormService: QueueServiceFormService;
  let queueServiceService: QueueServiceService;
  let queueDepartmentService: QueueDepartmentService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule, RouterTestingModule.withRoutes([]), QueueServiceUpdateComponent],
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
      .overrideTemplate(QueueServiceUpdateComponent, '')
      .compileComponents();

    fixture = TestBed.createComponent(QueueServiceUpdateComponent);
    activatedRoute = TestBed.inject(ActivatedRoute);
    queueServiceFormService = TestBed.inject(QueueServiceFormService);
    queueServiceService = TestBed.inject(QueueServiceService);
    queueDepartmentService = TestBed.inject(QueueDepartmentService);

    comp = fixture.componentInstance;
  });

  describe('ngOnInit', () => {
    it('Should call QueueDepartment query and add missing value', () => {
      const queueService: IQueueService = { id: 456 };
      const queueDepartment: IQueueDepartment = { id: 10338 };
      queueService.queueDepartment = queueDepartment;

      const queueDepartmentCollection: IQueueDepartment[] = [{ id: 540 }];
      jest.spyOn(queueDepartmentService, 'query').mockReturnValue(of(new HttpResponse({ body: queueDepartmentCollection })));
      const additionalQueueDepartments = [queueDepartment];
      const expectedCollection: IQueueDepartment[] = [...additionalQueueDepartments, ...queueDepartmentCollection];
      jest.spyOn(queueDepartmentService, 'addQueueDepartmentToCollectionIfMissing').mockReturnValue(expectedCollection);

      activatedRoute.data = of({ queueService });
      comp.ngOnInit();

      expect(queueDepartmentService.query).toHaveBeenCalled();
      expect(queueDepartmentService.addQueueDepartmentToCollectionIfMissing).toHaveBeenCalledWith(
        queueDepartmentCollection,
        ...additionalQueueDepartments.map(expect.objectContaining),
      );
      expect(comp.queueDepartmentsSharedCollection).toEqual(expectedCollection);
    });

    it('Should update editForm', () => {
      const queueService: IQueueService = { id: 456 };
      const queueDepartment: IQueueDepartment = { id: 16870 };
      queueService.queueDepartment = queueDepartment;

      activatedRoute.data = of({ queueService });
      comp.ngOnInit();

      expect(comp.queueDepartmentsSharedCollection).toContain(queueDepartment);
      expect(comp.queueService).toEqual(queueService);
    });
  });

  describe('save', () => {
    it('Should call update service on save for existing entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IQueueService>>();
      const queueService = { id: 123 };
      jest.spyOn(queueServiceFormService, 'getQueueService').mockReturnValue(queueService);
      jest.spyOn(queueServiceService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ queueService });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: queueService }));
      saveSubject.complete();

      // THEN
      expect(queueServiceFormService.getQueueService).toHaveBeenCalled();
      expect(comp.previousState).toHaveBeenCalled();
      expect(queueServiceService.update).toHaveBeenCalledWith(expect.objectContaining(queueService));
      expect(comp.isSaving).toEqual(false);
    });

    it('Should call create service on save for new entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IQueueService>>();
      const queueService = { id: 123 };
      jest.spyOn(queueServiceFormService, 'getQueueService').mockReturnValue({ id: null });
      jest.spyOn(queueServiceService, 'create').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ queueService: null });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: queueService }));
      saveSubject.complete();

      // THEN
      expect(queueServiceFormService.getQueueService).toHaveBeenCalled();
      expect(queueServiceService.create).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).toHaveBeenCalled();
    });

    it('Should set isSaving to false on error', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IQueueService>>();
      const queueService = { id: 123 };
      jest.spyOn(queueServiceService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ queueService });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.error('This is an error!');

      // THEN
      expect(queueServiceService.update).toHaveBeenCalled();
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
