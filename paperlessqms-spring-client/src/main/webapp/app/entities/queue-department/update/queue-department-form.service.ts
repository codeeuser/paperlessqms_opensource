import { Injectable } from '@angular/core';
import { FormGroup, FormControl, Validators } from '@angular/forms';

import { IQueueDepartment, NewQueueDepartment } from '../queue-department.model';

/**
 * A partial Type with required key is used as form input.
 */
type PartialWithRequiredKeyOf<T extends { id: unknown }> = Partial<Omit<T, 'id'>> & { id: T['id'] };

/**
 * Type for createFormGroup and resetForm argument.
 * It accepts IQueueDepartment for edit and NewQueueDepartmentFormGroupInput for create.
 */
type QueueDepartmentFormGroupInput = IQueueDepartment | PartialWithRequiredKeyOf<NewQueueDepartment>;

type QueueDepartmentFormDefaults = Pick<NewQueueDepartment, 'id' | 'selected' | 'enable'>;

type QueueDepartmentFormGroupContent = {
  id: FormControl<IQueueDepartment['id'] | NewQueueDepartment['id']>;
  profileBizId: FormControl<IQueueDepartment['profileBizId']>;
  bizName: FormControl<IQueueDepartment['bizName']>;
  bizCategoryName: FormControl<IQueueDepartment['bizCategoryName']>;
  name: FormControl<IQueueDepartment['name']>;
  desc: FormControl<IQueueDepartment['desc']>;
  lat: FormControl<IQueueDepartment['lat']>;
  lng: FormControl<IQueueDepartment['lng']>;
  timeZone: FormControl<IQueueDepartment['timeZone']>;
  threshold: FormControl<IQueueDepartment['threshold']>;
  nearbyRange: FormControl<IQueueDepartment['nearbyRange']>;
  tokenTimeoutMin: FormControl<IQueueDepartment['tokenTimeoutMin']>;
  selected: FormControl<IQueueDepartment['selected']>;
  enable: FormControl<IQueueDepartment['enable']>;
  orderNum: FormControl<IQueueDepartment['orderNum']>;
  currencySymbol: FormControl<IQueueDepartment['currencySymbol']>;
  lenMetric: FormControl<IQueueDepartment['lenMetric']>;
  currencyCode: FormControl<IQueueDepartment['currencyCode']>;
  bannerName: FormControl<IQueueDepartment['bannerName']>;
  createdDate: FormControl<IQueueDepartment['createdDate']>;
  modifiedDate: FormControl<IQueueDepartment['modifiedDate']>;
};

export type QueueDepartmentFormGroup = FormGroup<QueueDepartmentFormGroupContent>;

@Injectable({ providedIn: 'root' })
export class QueueDepartmentFormService {
  createQueueDepartmentFormGroup(queueDepartment: QueueDepartmentFormGroupInput = { id: null }): QueueDepartmentFormGroup {
    const queueDepartmentRawValue = {
      ...this.getFormDefaults(),
      ...queueDepartment,
    };
    return new FormGroup<QueueDepartmentFormGroupContent>({
      id: new FormControl(
        { value: queueDepartmentRawValue.id, disabled: true },
        {
          nonNullable: true,
          validators: [Validators.required],
        },
      ),
      profileBizId: new FormControl(queueDepartmentRawValue.profileBizId, {
        validators: [Validators.required],
      }),
      bizName: new FormControl(queueDepartmentRawValue.bizName, {
        validators: [Validators.required],
      }),
      bizCategoryName: new FormControl(queueDepartmentRawValue.bizCategoryName),
      name: new FormControl(queueDepartmentRawValue.name, {
        validators: [Validators.required],
      }),
      desc: new FormControl(queueDepartmentRawValue.desc),
      lat: new FormControl(queueDepartmentRawValue.lat),
      lng: new FormControl(queueDepartmentRawValue.lng),
      timeZone: new FormControl(queueDepartmentRawValue.timeZone),
      threshold: new FormControl(queueDepartmentRawValue.threshold),
      nearbyRange: new FormControl(queueDepartmentRawValue.nearbyRange),
      tokenTimeoutMin: new FormControl(queueDepartmentRawValue.tokenTimeoutMin),
      selected: new FormControl(queueDepartmentRawValue.selected),
      enable: new FormControl(queueDepartmentRawValue.enable),
      orderNum: new FormControl(queueDepartmentRawValue.orderNum),
      currencySymbol: new FormControl(queueDepartmentRawValue.currencySymbol),
      lenMetric: new FormControl(queueDepartmentRawValue.lenMetric),
      currencyCode: new FormControl(queueDepartmentRawValue.currencyCode),
      bannerName: new FormControl(queueDepartmentRawValue.bannerName),
      createdDate: new FormControl(queueDepartmentRawValue.createdDate),
      modifiedDate: new FormControl(queueDepartmentRawValue.modifiedDate),
    });
  }

  getQueueDepartment(form: QueueDepartmentFormGroup): IQueueDepartment | NewQueueDepartment {
    return form.getRawValue() as IQueueDepartment | NewQueueDepartment;
  }

  resetForm(form: QueueDepartmentFormGroup, queueDepartment: QueueDepartmentFormGroupInput): void {
    const queueDepartmentRawValue = { ...this.getFormDefaults(), ...queueDepartment };
    form.reset(
      {
        ...queueDepartmentRawValue,
        id: { value: queueDepartmentRawValue.id, disabled: true },
      } as any /* cast to workaround https://github.com/angular/angular/issues/46458 */,
    );
  }

  private getFormDefaults(): QueueDepartmentFormDefaults {
    return {
      id: null,
      selected: false,
      enable: false,
    };
  }
}
