import { Injectable } from '@angular/core';
import { FormGroup, FormControl, Validators } from '@angular/forms';

import { ITokenNumber, NewTokenNumber } from '../token-number.model';

/**
 * A partial Type with required key is used as form input.
 */
type PartialWithRequiredKeyOf<T extends { id: unknown }> = Partial<Omit<T, 'id'>> & { id: T['id'] };

/**
 * Type for createFormGroup and resetForm argument.
 * It accepts ITokenNumber for edit and NewTokenNumberFormGroupInput for create.
 */
type TokenNumberFormGroupInput = ITokenNumber | PartialWithRequiredKeyOf<NewTokenNumber>;

type TokenNumberFormDefaults = Pick<NewTokenNumber, 'id' | 'reset'>;

type TokenNumberFormGroupContent = {
  id: FormControl<ITokenNumber['id'] | NewTokenNumber['id']>;
  number: FormControl<ITokenNumber['number']>;
  departmentId: FormControl<ITokenNumber['departmentId']>;
  serviceId: FormControl<ITokenNumber['serviceId']>;
  reset: FormControl<ITokenNumber['reset']>;
};

export type TokenNumberFormGroup = FormGroup<TokenNumberFormGroupContent>;

@Injectable({ providedIn: 'root' })
export class TokenNumberFormService {
  createTokenNumberFormGroup(tokenNumber: TokenNumberFormGroupInput = { id: null }): TokenNumberFormGroup {
    const tokenNumberRawValue = {
      ...this.getFormDefaults(),
      ...tokenNumber,
    };
    return new FormGroup<TokenNumberFormGroupContent>({
      id: new FormControl(
        { value: tokenNumberRawValue.id, disabled: true },
        {
          nonNullable: true,
          validators: [Validators.required],
        },
      ),
      number: new FormControl(tokenNumberRawValue.number),
      departmentId: new FormControl(tokenNumberRawValue.departmentId),
      serviceId: new FormControl(tokenNumberRawValue.serviceId),
      reset: new FormControl(tokenNumberRawValue.reset),
    });
  }

  getTokenNumber(form: TokenNumberFormGroup): ITokenNumber | NewTokenNumber {
    return form.getRawValue() as ITokenNumber | NewTokenNumber;
  }

  resetForm(form: TokenNumberFormGroup, tokenNumber: TokenNumberFormGroupInput): void {
    const tokenNumberRawValue = { ...this.getFormDefaults(), ...tokenNumber };
    form.reset(
      {
        ...tokenNumberRawValue,
        id: { value: tokenNumberRawValue.id, disabled: true },
      } as any /* cast to workaround https://github.com/angular/angular/issues/46458 */,
    );
  }

  private getFormDefaults(): TokenNumberFormDefaults {
    return {
      id: null,
      reset: false,
    };
  }
}
