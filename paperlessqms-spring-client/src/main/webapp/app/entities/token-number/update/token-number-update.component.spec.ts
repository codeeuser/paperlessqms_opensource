import { ComponentFixture, TestBed } from '@angular/core/testing';
import { HttpResponse } from '@angular/common/http';
import { HttpClientTestingModule } from '@angular/common/http/testing';
import { FormBuilder } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { RouterTestingModule } from '@angular/router/testing';
import { of, Subject, from } from 'rxjs';

import { TokenNumberService } from '../service/token-number.service';
import { ITokenNumber } from '../token-number.model';
import { TokenNumberFormService } from './token-number-form.service';

import { TokenNumberUpdateComponent } from './token-number-update.component';

describe('TokenNumber Management Update Component', () => {
  let comp: TokenNumberUpdateComponent;
  let fixture: ComponentFixture<TokenNumberUpdateComponent>;
  let activatedRoute: ActivatedRoute;
  let tokenNumberFormService: TokenNumberFormService;
  let tokenNumberService: TokenNumberService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule, RouterTestingModule.withRoutes([]), TokenNumberUpdateComponent],
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
      .overrideTemplate(TokenNumberUpdateComponent, '')
      .compileComponents();

    fixture = TestBed.createComponent(TokenNumberUpdateComponent);
    activatedRoute = TestBed.inject(ActivatedRoute);
    tokenNumberFormService = TestBed.inject(TokenNumberFormService);
    tokenNumberService = TestBed.inject(TokenNumberService);

    comp = fixture.componentInstance;
  });

  describe('ngOnInit', () => {
    it('Should update editForm', () => {
      const tokenNumber: ITokenNumber = { id: 456 };

      activatedRoute.data = of({ tokenNumber });
      comp.ngOnInit();

      expect(comp.tokenNumber).toEqual(tokenNumber);
    });
  });

  describe('save', () => {
    it('Should call update service on save for existing entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<ITokenNumber>>();
      const tokenNumber = { id: 123 };
      jest.spyOn(tokenNumberFormService, 'getTokenNumber').mockReturnValue(tokenNumber);
      jest.spyOn(tokenNumberService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ tokenNumber });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: tokenNumber }));
      saveSubject.complete();

      // THEN
      expect(tokenNumberFormService.getTokenNumber).toHaveBeenCalled();
      expect(comp.previousState).toHaveBeenCalled();
      expect(tokenNumberService.update).toHaveBeenCalledWith(expect.objectContaining(tokenNumber));
      expect(comp.isSaving).toEqual(false);
    });

    it('Should call create service on save for new entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<ITokenNumber>>();
      const tokenNumber = { id: 123 };
      jest.spyOn(tokenNumberFormService, 'getTokenNumber').mockReturnValue({ id: null });
      jest.spyOn(tokenNumberService, 'create').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ tokenNumber: null });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: tokenNumber }));
      saveSubject.complete();

      // THEN
      expect(tokenNumberFormService.getTokenNumber).toHaveBeenCalled();
      expect(tokenNumberService.create).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).toHaveBeenCalled();
    });

    it('Should set isSaving to false on error', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<ITokenNumber>>();
      const tokenNumber = { id: 123 };
      jest.spyOn(tokenNumberService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ tokenNumber });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.error('This is an error!');

      // THEN
      expect(tokenNumberService.update).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).not.toHaveBeenCalled();
    });
  });
});
