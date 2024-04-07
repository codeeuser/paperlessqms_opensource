import { Injectable } from '@angular/core';
import { FormGroup, FormControl, Validators } from '@angular/forms';

import { IQueueService, NewQueueService } from '../queue-service.model';

/**
 * A partial Type with required key is used as form input.
 */
type PartialWithRequiredKeyOf<T extends { id: unknown }> = Partial<Omit<T, 'id'>> & { id: T['id'] };

/**
 * Type for createFormGroup and resetForm argument.
 * It accepts IQueueService for edit and NewQueueServiceFormGroupInput for create.
 */
type QueueServiceFormGroupInput = IQueueService | PartialWithRequiredKeyOf<NewQueueService>;

type QueueServiceFormDefaults = Pick<NewQueueService, 'id' | 'enable' | 'enableCatalog'>;

type QueueServiceFormGroupContent = {
  id: FormControl<IQueueService['id'] | NewQueueService['id']>;
  profileBizId: FormControl<IQueueService['profileBizId']>;
  name: FormControl<IQueueService['name']>;
  type: FormControl<IQueueService['type']>;
  letter: FormControl<IQueueService['letter']>;
  start: FormControl<IQueueService['start']>;
  desc: FormControl<IQueueService['desc']>;
  enable: FormControl<IQueueService['enable']>;
  orderNum: FormControl<IQueueService['orderNum']>;
  enableCatalog: FormControl<IQueueService['enableCatalog']>;
  createdDate: FormControl<IQueueService['createdDate']>;
  modifiedDate: FormControl<IQueueService['modifiedDate']>;
  queueDepartment: FormControl<IQueueService['queueDepartment']>;
};

export type QueueServiceFormGroup = FormGroup<QueueServiceFormGroupContent>;

@Injectable({ providedIn: 'root' })
export class QueueServiceFormService {
  createQueueServiceFormGroup(queueService: QueueServiceFormGroupInput = { id: null }): QueueServiceFormGroup {
    const queueServiceRawValue = {
      ...this.getFormDefaults(),
      ...queueService,
    };
    return new FormGroup<QueueServiceFormGroupContent>({
      id: new FormControl(
        { value: queueServiceRawValue.id, disabled: true },
        {
          nonNullable: true,
          validators: [Validators.required],
        },
      ),
      profileBizId: new FormControl(queueServiceRawValue.profileBizId, {
        validators: [Validators.required],
      }),
      name: new FormControl(queueServiceRawValue.name, {
        validators: [Validators.required],
      }),
      type: new FormControl(queueServiceRawValue.type),
      letter: new FormControl(queueServiceRawValue.letter),
      start: new FormControl(queueServiceRawValue.start),
      desc: new FormControl(queueServiceRawValue.desc),
      enable: new FormControl(queueServiceRawValue.enable),
      orderNum: new FormControl(queueServiceRawValue.orderNum),
      enableCatalog: new FormControl(queueServiceRawValue.enableCatalog),
      createdDate: new FormControl(queueServiceRawValue.createdDate),
      modifiedDate: new FormControl(queueServiceRawValue.modifiedDate),
      queueDepartment: new FormControl(queueServiceRawValue.queueDepartment),
    });
  }

  getQueueService(form: QueueServiceFormGroup): IQueueService | NewQueueService {
    return form.getRawValue() as IQueueService | NewQueueService;
  }

  resetForm(form: QueueServiceFormGroup, queueService: QueueServiceFormGroupInput): void {
    const queueServiceRawValue = { ...this.getFormDefaults(), ...queueService };
    form.reset(
      {
        ...queueServiceRawValue,
        id: { value: queueServiceRawValue.id, disabled: true },
      } as any /* cast to workaround https://github.com/angular/angular/issues/46458 */,
    );
  }

  private getFormDefaults(): QueueServiceFormDefaults {
    return {
      id: null,
      enable: false,
      enableCatalog: false,
    };
  }
}
