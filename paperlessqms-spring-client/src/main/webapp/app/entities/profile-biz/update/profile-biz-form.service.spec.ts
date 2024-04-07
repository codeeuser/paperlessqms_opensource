import { TestBed } from '@angular/core/testing';

import { sampleWithRequiredData, sampleWithNewData } from '../profile-biz.test-samples';

import { ProfileBizFormService } from './profile-biz-form.service';

describe('ProfileBiz Form Service', () => {
  let service: ProfileBizFormService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(ProfileBizFormService);
  });

  describe('Service methods', () => {
    describe('createProfileBizFormGroup', () => {
      it('should create a new form with FormControl', () => {
        const formGroup = service.createProfileBizFormGroup();

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            bizName: expect.any(Object),
            bizLogoBase64: expect.any(Object),
            bizPhotoBase64: expect.any(Object),
            bizAddress: expect.any(Object),
            bizLevel: expect.any(Object),
            bizEmail: expect.any(Object),
            bizPhoneNumber: expect.any(Object),
            bizPhoneCode: expect.any(Object),
            bizPhoneIsoCode: expect.any(Object),
            bizWebsite: expect.any(Object),
            bizDesc: expect.any(Object),
            enable: expect.any(Object),
            createdByUid: expect.any(Object),
            updatedByUid: expect.any(Object),
            modifiedDate: expect.any(Object),
            createdDate: expect.any(Object),
          }),
        );
      });

      it('passing IProfileBiz should create a new form with FormGroup', () => {
        const formGroup = service.createProfileBizFormGroup(sampleWithRequiredData);

        expect(formGroup.controls).toEqual(
          expect.objectContaining({
            id: expect.any(Object),
            bizName: expect.any(Object),
            bizLogoBase64: expect.any(Object),
            bizPhotoBase64: expect.any(Object),
            bizAddress: expect.any(Object),
            bizLevel: expect.any(Object),
            bizEmail: expect.any(Object),
            bizPhoneNumber: expect.any(Object),
            bizPhoneCode: expect.any(Object),
            bizPhoneIsoCode: expect.any(Object),
            bizWebsite: expect.any(Object),
            bizDesc: expect.any(Object),
            enable: expect.any(Object),
            createdByUid: expect.any(Object),
            updatedByUid: expect.any(Object),
            modifiedDate: expect.any(Object),
            createdDate: expect.any(Object),
          }),
        );
      });
    });

    describe('getProfileBiz', () => {
      it('should return NewProfileBiz for default ProfileBiz initial value', () => {
        const formGroup = service.createProfileBizFormGroup(sampleWithNewData);

        const profileBiz = service.getProfileBiz(formGroup) as any;

        expect(profileBiz).toMatchObject(sampleWithNewData);
      });

      it('should return NewProfileBiz for empty ProfileBiz initial value', () => {
        const formGroup = service.createProfileBizFormGroup();

        const profileBiz = service.getProfileBiz(formGroup) as any;

        expect(profileBiz).toMatchObject({});
      });

      it('should return IProfileBiz', () => {
        const formGroup = service.createProfileBizFormGroup(sampleWithRequiredData);

        const profileBiz = service.getProfileBiz(formGroup) as any;

        expect(profileBiz).toMatchObject(sampleWithRequiredData);
      });
    });

    describe('resetForm', () => {
      it('passing IProfileBiz should not enable id FormControl', () => {
        const formGroup = service.createProfileBizFormGroup();
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, sampleWithRequiredData);

        expect(formGroup.controls.id.disabled).toBe(true);
      });

      it('passing NewProfileBiz should disable id FormControl', () => {
        const formGroup = service.createProfileBizFormGroup(sampleWithRequiredData);
        expect(formGroup.controls.id.disabled).toBe(true);

        service.resetForm(formGroup, { id: null });

        expect(formGroup.controls.id.disabled).toBe(true);
      });
    });
  });
});
