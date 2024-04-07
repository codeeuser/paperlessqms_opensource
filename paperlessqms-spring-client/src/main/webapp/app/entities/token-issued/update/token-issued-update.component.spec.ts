import { ComponentFixture, TestBed } from '@angular/core/testing';
import { HttpResponse } from '@angular/common/http';
import { HttpClientTestingModule } from '@angular/common/http/testing';
import { FormBuilder } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { RouterTestingModule } from '@angular/router/testing';
import { of, Subject, from } from 'rxjs';

import { TokenIssuedService } from '../service/token-issued.service';
import { ITokenIssued } from '../token-issued.model';
import { TokenIssuedFormService } from './token-issued-form.service';

import { TokenIssuedUpdateComponent } from './token-issued-update.component';

describe('TokenIssued Management Update Component', () => {
  let comp: TokenIssuedUpdateComponent;
  let fixture: ComponentFixture<TokenIssuedUpdateComponent>;
  let activatedRoute: ActivatedRoute;
  let tokenIssuedFormService: TokenIssuedFormService;
  let tokenIssuedService: TokenIssuedService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule, RouterTestingModule.withRoutes([]), TokenIssuedUpdateComponent],
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
      .overrideTemplate(TokenIssuedUpdateComponent, '')
      .compileComponents();

    fixture = TestBed.createComponent(TokenIssuedUpdateComponent);
    activatedRoute = TestBed.inject(ActivatedRoute);
    tokenIssuedFormService = TestBed.inject(TokenIssuedFormService);
    tokenIssuedService = TestBed.inject(TokenIssuedService);

    comp = fixture.componentInstance;
  });

  describe('ngOnInit', () => {
    it('Should update editForm', () => {
      const tokenIssued: ITokenIssued = { id: 456 };

      activatedRoute.data = of({ tokenIssued });
      comp.ngOnInit();

      expect(comp.tokenIssued).toEqual(tokenIssued);
    });
  });

  describe('save', () => {
    it('Should call update service on save for existing entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<ITokenIssued>>();
      const tokenIssued = { id: 123 };
      jest.spyOn(tokenIssuedFormService, 'getTokenIssued').mockReturnValue(tokenIssued);
      jest.spyOn(tokenIssuedService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ tokenIssued });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: tokenIssued }));
      saveSubject.complete();

      // THEN
      expect(tokenIssuedFormService.getTokenIssued).toHaveBeenCalled();
      expect(comp.previousState).toHaveBeenCalled();
      expect(tokenIssuedService.update).toHaveBeenCalledWith(expect.objectContaining(tokenIssued));
      expect(comp.isSaving).toEqual(false);
    });

    it('Should call create service on save for new entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<ITokenIssued>>();
      const tokenIssued = { id: 123 };
      jest.spyOn(tokenIssuedFormService, 'getTokenIssued').mockReturnValue({ id: null });
      jest.spyOn(tokenIssuedService, 'create').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ tokenIssued: null });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: tokenIssued }));
      saveSubject.complete();

      // THEN
      expect(tokenIssuedFormService.getTokenIssued).toHaveBeenCalled();
      expect(tokenIssuedService.create).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).toHaveBeenCalled();
    });

    it('Should set isSaving to false on error', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<ITokenIssued>>();
      const tokenIssued = { id: 123 };
      jest.spyOn(tokenIssuedService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ tokenIssued });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.error('This is an error!');

      // THEN
      expect(tokenIssuedService.update).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).not.toHaveBeenCalled();
    });
  });
});
