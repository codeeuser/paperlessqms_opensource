import { Injectable } from '@angular/core';
import { FormGroup, FormControl, Validators } from '@angular/forms';

import { IAgent, NewAgent } from '../agent.model';

/**
 * A partial Type with required key is used as form input.
 */
type PartialWithRequiredKeyOf<T extends { id: unknown }> = Partial<Omit<T, 'id'>> & { id: T['id'] };

/**
 * Type for createFormGroup and resetForm argument.
 * It accepts IAgent for edit and NewAgentFormGroupInput for create.
 */
type AgentFormGroupInput = IAgent | PartialWithRequiredKeyOf<NewAgent>;

type AgentFormDefaults = Pick<NewAgent, 'id' | 'enable'>;

type AgentFormGroupContent = {
  id: FormControl<IAgent['id'] | NewAgent['id']>;
  profileBizId: FormControl<IAgent['profileBizId']>;
  uid: FormControl<IAgent['uid']>;
  login: FormControl<IAgent['login']>;
  email: FormControl<IAgent['email']>;
  updateUid: FormControl<IAgent['updateUid']>;
  enable: FormControl<IAgent['enable']>;
  orderNum: FormControl<IAgent['orderNum']>;
  createdDate: FormControl<IAgent['createdDate']>;
  modifiedDate: FormControl<IAgent['modifiedDate']>;
  queueTerminal: FormControl<IAgent['queueTerminal']>;
  queueDepartment: FormControl<IAgent['queueDepartment']>;
};

export type AgentFormGroup = FormGroup<AgentFormGroupContent>;

@Injectable({ providedIn: 'root' })
export class AgentFormService {
  createAgentFormGroup(agent: AgentFormGroupInput = { id: null }): AgentFormGroup {
    const agentRawValue = {
      ...this.getFormDefaults(),
      ...agent,
    };
    return new FormGroup<AgentFormGroupContent>({
      id: new FormControl(
        { value: agentRawValue.id, disabled: true },
        {
          nonNullable: true,
          validators: [Validators.required],
        },
      ),
      profileBizId: new FormControl(agentRawValue.profileBizId, {
        validators: [Validators.required],
      }),
      uid: new FormControl(agentRawValue.uid, {
        validators: [Validators.required],
      }),
      login: new FormControl(agentRawValue.login, {
        validators: [Validators.required],
      }),
      email: new FormControl(agentRawValue.email, {
        validators: [Validators.required],
      }),
      updateUid: new FormControl(agentRawValue.updateUid),
      enable: new FormControl(agentRawValue.enable),
      orderNum: new FormControl(agentRawValue.orderNum),
      createdDate: new FormControl(agentRawValue.createdDate),
      modifiedDate: new FormControl(agentRawValue.modifiedDate),
      queueTerminal: new FormControl(agentRawValue.queueTerminal),
      queueDepartment: new FormControl(agentRawValue.queueDepartment),
    });
  }

  getAgent(form: AgentFormGroup): IAgent | NewAgent {
    return form.getRawValue() as IAgent | NewAgent;
  }

  resetForm(form: AgentFormGroup, agent: AgentFormGroupInput): void {
    const agentRawValue = { ...this.getFormDefaults(), ...agent };
    form.reset(
      {
        ...agentRawValue,
        id: { value: agentRawValue.id, disabled: true },
      } as any /* cast to workaround https://github.com/angular/angular/issues/46458 */,
    );
  }

  private getFormDefaults(): AgentFormDefaults {
    return {
      id: null,
      enable: false,
    };
  }
}
