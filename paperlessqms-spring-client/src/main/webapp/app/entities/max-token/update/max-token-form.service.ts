import { Injectable } from '@angular/core';
import { FormGroup, FormControl, Validators } from '@angular/forms';

import { IMaxToken, NewMaxToken } from '../max-token.model';

/**
 * A partial Type with required key is used as form input.
 */
type PartialWithRequiredKeyOf<T extends { id: unknown }> = Partial<Omit<T, 'id'>> & { id: T['id'] };

/**
 * Type for createFormGroup and resetForm argument.
 * It accepts IMaxToken for edit and NewMaxTokenFormGroupInput for create.
 */
type MaxTokenFormGroupInput = IMaxToken | PartialWithRequiredKeyOf<NewMaxToken>;

type MaxTokenFormDefaults = Pick<NewMaxToken, 'id'>;

type MaxTokenFormGroupContent = {
  id: FormControl<IMaxToken['id'] | NewMaxToken['id']>;
  profileBizId: FormControl<IMaxToken['profileBizId']>;
  maxToken: FormControl<IMaxToken['maxToken']>;
  dayNum: FormControl<IMaxToken['dayNum']>;
  modifiedDate: FormControl<IMaxToken['modifiedDate']>;
  createdDate: FormControl<IMaxToken['createdDate']>;
};

export type MaxTokenFormGroup = FormGroup<MaxTokenFormGroupContent>;

@Injectable({ providedIn: 'root' })
export class MaxTokenFormService {
  createMaxTokenFormGroup(maxToken: MaxTokenFormGroupInput = { id: null }): MaxTokenFormGroup {
    const maxTokenRawValue = {
      ...this.getFormDefaults(),
      ...maxToken,
    };
    return new FormGroup<MaxTokenFormGroupContent>({
      id: new FormControl(
        { value: maxTokenRawValue.id, disabled: true },
        {
          nonNullable: true,
          validators: [Validators.required],
        },
      ),
      profileBizId: new FormControl(maxTokenRawValue.profileBizId, {
        validators: [Validators.required],
      }),
      maxToken: new FormControl(maxTokenRawValue.maxToken, {
        validators: [Validators.required],
      }),
      dayNum: new FormControl(maxTokenRawValue.dayNum, {
        validators: [Validators.required],
      }),
      modifiedDate: new FormControl(maxTokenRawValue.modifiedDate),
      createdDate: new FormControl(maxTokenRawValue.createdDate),
    });
  }

  getMaxToken(form: MaxTokenFormGroup): IMaxToken | NewMaxToken {
    return form.getRawValue() as IMaxToken | NewMaxToken;
  }

  resetForm(form: MaxTokenFormGroup, maxToken: MaxTokenFormGroupInput): void {
    const maxTokenRawValue = { ...this.getFormDefaults(), ...maxToken };
    form.reset(
      {
        ...maxTokenRawValue,
        id: { value: maxTokenRawValue.id, disabled: true },
      } as any /* cast to workaround https://github.com/angular/angular/issues/46458 */,
    );
  }

  private getFormDefaults(): MaxTokenFormDefaults {
    return {
      id: null,
    };
  }
}
