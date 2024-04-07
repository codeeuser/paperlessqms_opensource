import { Injectable } from '@angular/core';
import { FormGroup, FormControl, Validators } from '@angular/forms';

import { IOpenHour, NewOpenHour } from '../open-hour.model';

/**
 * A partial Type with required key is used as form input.
 */
type PartialWithRequiredKeyOf<T extends { id: unknown }> = Partial<Omit<T, 'id'>> & { id: T['id'] };

/**
 * Type for createFormGroup and resetForm argument.
 * It accepts IOpenHour for edit and NewOpenHourFormGroupInput for create.
 */
type OpenHourFormGroupInput = IOpenHour | PartialWithRequiredKeyOf<NewOpenHour>;

type OpenHourFormDefaults = Pick<NewOpenHour, 'id' | 'enable'>;

type OpenHourFormGroupContent = {
  id: FormControl<IOpenHour['id'] | NewOpenHour['id']>;
  profileBizId: FormControl<IOpenHour['profileBizId']>;
  startHour: FormControl<IOpenHour['startHour']>;
  startMin: FormControl<IOpenHour['startMin']>;
  endHour: FormControl<IOpenHour['endHour']>;
  endMin: FormControl<IOpenHour['endMin']>;
  dayNum: FormControl<IOpenHour['dayNum']>;
  enable: FormControl<IOpenHour['enable']>;
  modifiedDate: FormControl<IOpenHour['modifiedDate']>;
  createdDate: FormControl<IOpenHour['createdDate']>;
};

export type OpenHourFormGroup = FormGroup<OpenHourFormGroupContent>;

@Injectable({ providedIn: 'root' })
export class OpenHourFormService {
  createOpenHourFormGroup(openHour: OpenHourFormGroupInput = { id: null }): OpenHourFormGroup {
    const openHourRawValue = {
      ...this.getFormDefaults(),
      ...openHour,
    };
    return new FormGroup<OpenHourFormGroupContent>({
      id: new FormControl(
        { value: openHourRawValue.id, disabled: true },
        {
          nonNullable: true,
          validators: [Validators.required],
        },
      ),
      profileBizId: new FormControl(openHourRawValue.profileBizId, {
        validators: [Validators.required],
      }),
      startHour: new FormControl(openHourRawValue.startHour, {
        validators: [Validators.required],
      }),
      startMin: new FormControl(openHourRawValue.startMin, {
        validators: [Validators.required],
      }),
      endHour: new FormControl(openHourRawValue.endHour, {
        validators: [Validators.required],
      }),
      endMin: new FormControl(openHourRawValue.endMin, {
        validators: [Validators.required],
      }),
      dayNum: new FormControl(openHourRawValue.dayNum, {
        validators: [Validators.required],
      }),
      enable: new FormControl(openHourRawValue.enable),
      modifiedDate: new FormControl(openHourRawValue.modifiedDate),
      createdDate: new FormControl(openHourRawValue.createdDate),
    });
  }

  getOpenHour(form: OpenHourFormGroup): IOpenHour | NewOpenHour {
    return form.getRawValue() as IOpenHour | NewOpenHour;
  }

  resetForm(form: OpenHourFormGroup, openHour: OpenHourFormGroupInput): void {
    const openHourRawValue = { ...this.getFormDefaults(), ...openHour };
    form.reset(
      {
        ...openHourRawValue,
        id: { value: openHourRawValue.id, disabled: true },
      } as any /* cast to workaround https://github.com/angular/angular/issues/46458 */,
    );
  }

  private getFormDefaults(): OpenHourFormDefaults {
    return {
      id: null,
      enable: false,
    };
  }
}
