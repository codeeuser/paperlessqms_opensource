import { ComponentFixture, TestBed } from '@angular/core/testing';
import { HttpResponse } from '@angular/common/http';
import { HttpClientTestingModule } from '@angular/common/http/testing';
import { FormBuilder } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { RouterTestingModule } from '@angular/router/testing';
import { of, Subject, from } from 'rxjs';

import { ProfileBizService } from '../service/profile-biz.service';
import { IProfileBiz } from '../profile-biz.model';
import { ProfileBizFormService } from './profile-biz-form.service';

import { ProfileBizUpdateComponent } from './profile-biz-update.component';

describe('ProfileBiz Management Update Component', () => {
  let comp: ProfileBizUpdateComponent;
  let fixture: ComponentFixture<ProfileBizUpdateComponent>;
  let activatedRoute: ActivatedRoute;
  let profileBizFormService: ProfileBizFormService;
  let profileBizService: ProfileBizService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule, RouterTestingModule.withRoutes([]), ProfileBizUpdateComponent],
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
      .overrideTemplate(ProfileBizUpdateComponent, '')
      .compileComponents();

    fixture = TestBed.createComponent(ProfileBizUpdateComponent);
    activatedRoute = TestBed.inject(ActivatedRoute);
    profileBizFormService = TestBed.inject(ProfileBizFormService);
    profileBizService = TestBed.inject(ProfileBizService);

    comp = fixture.componentInstance;
  });

  describe('ngOnInit', () => {
    it('Should update editForm', () => {
      const profileBiz: IProfileBiz = { id: 456 };

      activatedRoute.data = of({ profileBiz });
      comp.ngOnInit();

      expect(comp.profileBiz).toEqual(profileBiz);
    });
  });

  describe('save', () => {
    it('Should call update service on save for existing entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IProfileBiz>>();
      const profileBiz = { id: 123 };
      jest.spyOn(profileBizFormService, 'getProfileBiz').mockReturnValue(profileBiz);
      jest.spyOn(profileBizService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ profileBiz });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: profileBiz }));
      saveSubject.complete();

      // THEN
      expect(profileBizFormService.getProfileBiz).toHaveBeenCalled();
      expect(comp.previousState).toHaveBeenCalled();
      expect(profileBizService.update).toHaveBeenCalledWith(expect.objectContaining(profileBiz));
      expect(comp.isSaving).toEqual(false);
    });

    it('Should call create service on save for new entity', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IProfileBiz>>();
      const profileBiz = { id: 123 };
      jest.spyOn(profileBizFormService, 'getProfileBiz').mockReturnValue({ id: null });
      jest.spyOn(profileBizService, 'create').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ profileBiz: null });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.next(new HttpResponse({ body: profileBiz }));
      saveSubject.complete();

      // THEN
      expect(profileBizFormService.getProfileBiz).toHaveBeenCalled();
      expect(profileBizService.create).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).toHaveBeenCalled();
    });

    it('Should set isSaving to false on error', () => {
      // GIVEN
      const saveSubject = new Subject<HttpResponse<IProfileBiz>>();
      const profileBiz = { id: 123 };
      jest.spyOn(profileBizService, 'update').mockReturnValue(saveSubject);
      jest.spyOn(comp, 'previousState');
      activatedRoute.data = of({ profileBiz });
      comp.ngOnInit();

      // WHEN
      comp.save();
      expect(comp.isSaving).toEqual(true);
      saveSubject.error('This is an error!');

      // THEN
      expect(profileBizService.update).toHaveBeenCalled();
      expect(comp.isSaving).toEqual(false);
      expect(comp.previousState).not.toHaveBeenCalled();
    });
  });
});
