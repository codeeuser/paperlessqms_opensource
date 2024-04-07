import { Injectable } from '@angular/core';
import { FormGroup, FormControl, Validators } from '@angular/forms';

import { IQueueTerminal, NewQueueTerminal } from '../queue-terminal.model';

/**
 * A partial Type with required key is used as form input.
 */
type PartialWithRequiredKeyOf<T extends { id: unknown }> = Partial<Omit<T, 'id'>> & { id: T['id'] };

/**
 * Type for createFormGroup and resetForm argument.
 * It accepts IQueueTerminal for edit and NewQueueTerminalFormGroupInput for create.
 */
type QueueTerminalFormGroupInput = IQueueTerminal | PartialWithRequiredKeyOf<NewQueueTerminal>;

type QueueTerminalFormDefaults = Pick<NewQueueTerminal, 'id' | 'enable'>;

type QueueTerminalFormGroupContent = {
  id: FormControl<IQueueTerminal['id'] | NewQueueTerminal['id']>;
  profileBizId: FormControl<IQueueTerminal['profileBizId']>;
  name: FormControl<IQueueTerminal['name']>;
  enable: FormControl<IQueueTerminal['enable']>;
  orderNum: FormControl<IQueueTerminal['orderNum']>;
  createdDate: FormControl<IQueueTerminal['createdDate']>;
  modifiedDate: FormControl<IQueueTerminal['modifiedDate']>;
  queueDepartment: FormControl<IQueueTerminal['queueDepartment']>;
};

export type QueueTerminalFormGroup = FormGroup<QueueTerminalFormGroupContent>;

@Injectable({ providedIn: 'root' })
export class QueueTerminalFormService {
  createQueueTerminalFormGroup(queueTerminal: QueueTerminalFormGroupInput = { id: null }): QueueTerminalFormGroup {
    const queueTerminalRawValue = {
      ...this.getFormDefaults(),
      ...queueTerminal,
    };
    return new FormGroup<QueueTerminalFormGroupContent>({
      id: new FormControl(
        { value: queueTerminalRawValue.id, disabled: true },
        {
          nonNullable: true,
          validators: [Validators.required],
        },
      ),
      profileBizId: new FormControl(queueTerminalRawValue.profileBizId, {
        validators: [Validators.required],
      }),
      name: new FormControl(queueTerminalRawValue.name, {
        validators: [Validators.required],
      }),
      enable: new FormControl(queueTerminalRawValue.enable),
      orderNum: new FormControl(queueTerminalRawValue.orderNum),
      createdDate: new FormControl(queueTerminalRawValue.createdDate),
      modifiedDate: new FormControl(queueTerminalRawValue.modifiedDate),
      queueDepartment: new FormControl(queueTerminalRawValue.queueDepartment),
    });
  }

  getQueueTerminal(form: QueueTerminalFormGroup): IQueueTerminal | NewQueueTerminal {
    return form.getRawValue() as IQueueTerminal | NewQueueTerminal;
  }

  resetForm(form: QueueTerminalFormGroup, queueTerminal: QueueTerminalFormGroupInput): void {
    const queueTerminalRawValue = { ...this.getFormDefaults(), ...queueTerminal };
    form.reset(
      {
        ...queueTerminalRawValue,
        id: { value: queueTerminalRawValue.id, disabled: true },
      } as any /* cast to workaround https://github.com/angular/angular/issues/46458 */,
    );
  }

  private getFormDefaults(): QueueTerminalFormDefaults {
    return {
      id: null,
      enable: false,
    };
  }
}
