import { ComponentFixture, TestBed } from '@angular/core/testing';
import { HttpResponse } from '@angular/common/http';
import { HttpClientTestingModule } from '@angular/common/http/testing';
import { FormBuilder } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { RouterTestingModule } from '@angular/router/testing';
import { of, Subject, from } from 'rxjs';

import { QueueDepartmentService } from '../service/queue-department.service';
import { IQueueDepartment } from '../queue-department.model';
import { QueueDepartmentFormService } from './queue-department-form.service';

import { QueueDepartmentUpdateComponent } from './queue-department-update.component';

describe('QueueDepartment Management Update Component', () => {
  let comp: QueueDepartmentUpdateComponent;
  let fixture: ComponentFixture<QueueDepartmentUpdateComponent>;
  let activatedRoute: ActivatedRoute;
  let queueDepartmentFormService: QueueDepartmentFormService;
  let queueDepartmentService: QueueDepartmentService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule, RouterTestingModule.withRoutes([]), QueueDepartmentUpdateComponent],
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
      .overrideTemplate(QueueDepartmentUpdateComponent, '')
      .compileComponents();

    fixture = TestBed.createComponent(QueueDepartmentUpdateComponent);
    activatedRoute = TestBed.inject(ActivatedRoute);
    queueDepartmentFormService = TestBed.inject(QueueDepartmentFormService);
    queueDepartmentService = TestBed.inject(QueueDepartmentService);

    comp = fixture.componentInstance;
  });

  describe('ngOnInit', () => {
    it('Should update editForm', () => {
      const queueDepartment: IQueueDepartment = { id: 456 };

      activatedRoute.data = of({ queueDepartment });
      comp.ngOnInit();

      expect(comp.queueDepartment).toEqual(queueDepartment);
    });
  });

  describe('save', () => {
    it('Should call update service on save for existing entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IQueueDepartment>>();
      const queueDepartment = { id: 123 };
      jest.spyOn(queueDepartmentFormService, 'getQueueDepartment').mockReturnValue(queueDepartment);
      jest.spyOn(queueDepartmentService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ queueDepartment });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: queueDepartment }));
      saveSubject.complete();

      // THEN
      expect(queueDepartmentFormService.getQueueDepartment).toHaveBeenCalled();
      expect(comp.previousState).toHaveBeenCalled();
      expect(queueDepartmentService.update).toHaveBeenCalledWith(expect.objectContaining(queueDepartment));
      expect(comp.isSaving).toEqual(false);
    });

    it('Should call create service on save for new entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IQueueDepartment>>();
      const queueDepartment = { id: 123 };
      jest.spyOn(queueDepartmentFormService, 'getQueueDepartment').mockReturnValue({ id: null });
      jest.spyOn(queueDepartmentService, 'create').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ queueDepartment: null });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: queueDepartment }));
      saveSubject.complete();

      // THEN
      expect(queueDepartmentFormService.getQueueDepartment).toHaveBeenCalled();
      expect(queueDepartmentService.create).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).toHaveBeenCalled();
    });

    it('Should set isSaving to false on error', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IQueueDepartment>>();
      const queueDepartment = { id: 123 };
      jest.spyOn(queueDepartmentService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ queueDepartment });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.error('This is an error!');

      // THEN
      expect(queueDepartmentService.update).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).not.toHaveBeenCalled();
    });
  });
});
