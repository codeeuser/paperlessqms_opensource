import { ComponentFixture, TestBed } from '@angular/core/testing';
import { HttpResponse } from '@angular/common/http';
import { HttpClientTestingModule } from '@angular/common/http/testing';
import { FormBuilder } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { RouterTestingModule } from '@angular/router/testing';
import { of, Subject, from } from 'rxjs';

import { OpenHourService } from '../service/open-hour.service';
import { IOpenHour } from '../open-hour.model';
import { OpenHourFormService } from './open-hour-form.service';

import { OpenHourUpdateComponent } from './open-hour-update.component';

describe('OpenHour Management Update Component', () => {
  let comp: OpenHourUpdateComponent;
  let fixture: ComponentFixture<OpenHourUpdateComponent>;
  let activatedRoute: ActivatedRoute;
  let openHourFormService: OpenHourFormService;
  let openHourService: OpenHourService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule, RouterTestingModule.withRoutes([]), OpenHourUpdateComponent],
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
      .overrideTemplate(OpenHourUpdateComponent, '')
      .compileComponents();

    fixture = TestBed.createComponent(OpenHourUpdateComponent);
    activatedRoute = TestBed.inject(ActivatedRoute);
    openHourFormService = TestBed.inject(OpenHourFormService);
    openHourService = TestBed.inject(OpenHourService);

    comp = fixture.componentInstance;
  });

  describe('ngOnInit', () => {
    it('Should update editForm', () => {
      const openHour: IOpenHour = { id: 456 };

      activatedRoute.data = of({ openHour });
      comp.ngOnInit();

      expect(comp.openHour).toEqual(openHour);
    });
  });

  describe('save', () => {
    it('Should call update service on save for existing entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IOpenHour>>();
      const openHour = { id: 123 };
      jest.spyOn(openHourFormService, 'getOpenHour').mockReturnValue(openHour);
      jest.spyOn(openHourService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ openHour });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: openHour }));
      saveSubject.complete();

      // THEN
      expect(openHourFormService.getOpenHour).toHaveBeenCalled();
      expect(comp.previousState).toHaveBeenCalled();
      expect(openHourService.update).toHaveBeenCalledWith(expect.objectContaining(openHour));
      expect(comp.isSaving).toEqual(false);
    });

    it('Should call create service on save for new entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IOpenHour>>();
      const openHour = { id: 123 };
      jest.spyOn(openHourFormService, 'getOpenHour').mockReturnValue({ id: null });
      jest.spyOn(openHourService, 'create').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ openHour: null });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: openHour }));
      saveSubject.complete();

      // THEN
      expect(openHourFormService.getOpenHour).toHaveBeenCalled();
      expect(openHourService.create).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).toHaveBeenCalled();
    });

    it('Should set isSaving to false on error', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IOpenHour>>();
      const openHour = { id: 123 };
      jest.spyOn(openHourService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ openHour });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.error('This is an error!');

      // THEN
      expect(openHourService.update).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).not.toHaveBeenCalled();
    });
  });
});
