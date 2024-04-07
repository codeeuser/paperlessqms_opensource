import { ComponentFixture, TestBed } from '@angular/core/testing';
import { HttpResponse } from '@angular/common/http';
import { HttpClientTestingModule } from '@angular/common/http/testing';
import { FormBuilder } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { RouterTestingModule } from '@angular/router/testing';
import { of, Subject, from } from 'rxjs';

import { MaxTokenService } from '../service/max-token.service';
import { IMaxToken } from '../max-token.model';
import { MaxTokenFormService } from './max-token-form.service';

import { MaxTokenUpdateComponent } from './max-token-update.component';

describe('MaxToken Management Update Component', () => {
  let comp: MaxTokenUpdateComponent;
  let fixture: ComponentFixture<MaxTokenUpdateComponent>;
  let activatedRoute: ActivatedRoute;
  let maxTokenFormService: MaxTokenFormService;
  let maxTokenService: MaxTokenService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule, RouterTestingModule.withRoutes([]), MaxTokenUpdateComponent],
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
      .overrideTemplate(MaxTokenUpdateComponent, '')
      .compileComponents();

    fixture = TestBed.createComponent(MaxTokenUpdateComponent);
    activatedRoute = TestBed.inject(ActivatedRoute);
    maxTokenFormService = TestBed.inject(MaxTokenFormService);
    maxTokenService = TestBed.inject(MaxTokenService);

    comp = fixture.componentInstance;
  });

  describe('ngOnInit', () => {
    it('Should update editForm', () => {
      const maxToken: IMaxToken = { id: 456 };

      activatedRoute.data = of({ maxToken });
      comp.ngOnInit();

      expect(comp.maxToken).toEqual(maxToken);
    });
  });

  describe('save', () => {
    it('Should call update service on save for existing entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IMaxToken>>();
      const maxToken = { id: 123 };
      jest.spyOn(maxTokenFormService, 'getMaxToken').mockReturnValue(maxToken);
      jest.spyOn(maxTokenService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ maxToken });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: maxToken }));
      saveSubject.complete();

      // THEN
      expect(maxTokenFormService.getMaxToken).toHaveBeenCalled();
      expect(comp.previousState).toHaveBeenCalled();
      expect(maxTokenService.update).toHaveBeenCalledWith(expect.objectContaining(maxToken));
      expect(comp.isSaving).toEqual(false);
    });

    it('Should call create service on save for new entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IMaxToken>>();
      const maxToken = { id: 123 };
      jest.spyOn(maxTokenFormService, 'getMaxToken').mockReturnValue({ id: null });
      jest.spyOn(maxTokenService, 'create').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ maxToken: null });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: maxToken }));
      saveSubject.complete();

      // THEN
      expect(maxTokenFormService.getMaxToken).toHaveBeenCalled();
      expect(maxTokenService.create).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).toHaveBeenCalled();
    });

    it('Should set isSaving to false on error', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IMaxToken>>();
      const maxToken = { id: 123 };
      jest.spyOn(maxTokenService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ maxToken });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.error('This is an error!');

      // THEN
      expect(maxTokenService.update).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).not.toHaveBeenCalled();
    });
  });
});
