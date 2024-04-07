import { Injectable } from '@angular/core';
import { FormGroup, FormControl, Validators } from '@angular/forms';

import { IProfileBiz, NewProfileBiz } from '../profile-biz.model';

/**
 * A partial Type with required key is used as form input.
 */
type PartialWithRequiredKeyOf<T extends { id: unknown }> = Partial<Omit<T, 'id'>> & { id: T['id'] };

/**
 * Type for createFormGroup and resetForm argument.
 * It accepts IProfileBiz for edit and NewProfileBizFormGroupInput for create.
 */
type ProfileBizFormGroupInput = IProfileBiz | PartialWithRequiredKeyOf<NewProfileBiz>;

type ProfileBizFormDefaults = Pick<NewProfileBiz, 'id' | 'enable'>;

type ProfileBizFormGroupContent = {
  id: FormControl<IProfileBiz['id'] | NewProfileBiz['id']>;
  bizName: FormControl<IProfileBiz['bizName']>;
  bizLogoBase64: FormControl<IProfileBiz['bizLogoBase64']>;
  bizPhotoBase64: FormControl<IProfileBiz['bizPhotoBase64']>;
  bizAddress: FormControl<IProfileBiz['bizAddress']>;
  bizLevel: FormControl<IProfileBiz['bizLevel']>;
  bizEmail: FormControl<IProfileBiz['bizEmail']>;
  bizPhoneNumber: FormControl<IProfileBiz['bizPhoneNumber']>;
  bizPhoneCode: FormControl<IProfileBiz['bizPhoneCode']>;
  bizPhoneIsoCode: FormControl<IProfileBiz['bizPhoneIsoCode']>;
  bizWebsite: FormControl<IProfileBiz['bizWebsite']>;
  bizDesc: FormControl<IProfileBiz['bizDesc']>;
  enable: FormControl<IProfileBiz['enable']>;
  createdByUid: FormControl<IProfileBiz['createdByUid']>;
  updatedByUid: FormControl<IProfileBiz['updatedByUid']>;
  modifiedDate: FormControl<IProfileBiz['modifiedDate']>;
  createdDate: FormControl<IProfileBiz['createdDate']>;
};

export type ProfileBizFormGroup = FormGroup<ProfileBizFormGroupContent>;

@Injectable({ providedIn: 'root' })
export class ProfileBizFormService {
  createProfileBizFormGroup(profileBiz: ProfileBizFormGroupInput = { id: null }): ProfileBizFormGroup {
    const profileBizRawValue = {
      ...this.getFormDefaults(),
      ...profileBiz,
    };
    return new FormGroup<ProfileBizFormGroupContent>({
      id: new FormControl(
        { value: profileBizRawValue.id, disabled: true },
        {
          nonNullable: true,
          validators: [Validators.required],
        },
      ),
      bizName: new FormControl(profileBizRawValue.bizName, {
        validators: [Validators.required],
      }),
      bizLogoBase64: new FormControl(profileBizRawValue.bizLogoBase64),
      bizPhotoBase64: new FormControl(profileBizRawValue.bizPhotoBase64),
      bizAddress: new FormControl(profileBizRawValue.bizAddress),
      bizLevel: new FormControl(profileBizRawValue.bizLevel),
      bizEmail: new FormControl(profileBizRawValue.bizEmail),
      bizPhoneNumber: new FormControl(profileBizRawValue.bizPhoneNumber),
      bizPhoneCode: new FormControl(profileBizRawValue.bizPhoneCode),
      bizPhoneIsoCode: new FormControl(profileBizRawValue.bizPhoneIsoCode),
      bizWebsite: new FormControl(profileBizRawValue.bizWebsite),
      bizDesc: new FormControl(profileBizRawValue.bizDesc),
      enable: new FormControl(profileBizRawValue.enable),
      createdByUid: new FormControl(profileBizRawValue.createdByUid),
      updatedByUid: new FormControl(profileBizRawValue.updatedByUid),
      modifiedDate: new FormControl(profileBizRawValue.modifiedDate),
      createdDate: new FormControl(profileBizRawValue.createdDate),
    });
  }

  getProfileBiz(form: ProfileBizFormGroup): IProfileBiz | NewProfileBiz {
    return form.getRawValue() as IProfileBiz | NewProfileBiz;
  }

  resetForm(form: ProfileBizFormGroup, profileBiz: ProfileBizFormGroupInput): void {
    const profileBizRawValue = { ...this.getFormDefaults(), ...profileBiz };
    form.reset(
      {
        ...profileBizRawValue,
        id: { value: profileBizRawValue.id, disabled: true },
      } as any /* cast to workaround https://github.com/angular/angular/issues/46458 */,
    );
  }

  private getFormDefaults(): ProfileBizFormDefaults {
    return {
      id: null,
      enable: false,
    };
  }
}
