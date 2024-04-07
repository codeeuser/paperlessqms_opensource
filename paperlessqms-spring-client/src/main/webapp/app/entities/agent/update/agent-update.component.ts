import { Component, OnInit } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRoute } from '@angular/router';
import { Observable } from 'rxjs';
import { finalize, map } from 'rxjs/operators';

import SharedModule from 'app/shared/shared.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { IQueueTerminal } from 'app/entities/queue-terminal/queue-terminal.model';
import { QueueTerminalService } from 'app/entities/queue-terminal/service/queue-terminal.service';
import { IQueueDepartment } from 'app/entities/queue-department/queue-department.model';
import { QueueDepartmentService } from 'app/entities/queue-department/service/queue-department.service';
import { AgentService } from '../service/agent.service';
import { IAgent } from '../agent.model';
import { AgentFormService, AgentFormGroup } from './agent-form.service';

@Component({
  standalone: true,
  selector: 'qms-agent-update',
  templateUrl: './agent-update.component.html',
  imports: [SharedModule, FormsModule, ReactiveFormsModule],
})
export class AgentUpdateComponent implements OnInit {
  isSaving = false;
  agent: IAgent | null = null;

  queueTerminalsSharedCollection: IQueueTerminal[] = [];
  queueDepartmentsSharedCollection: IQueueDepartment[] = [];

  editForm: AgentFormGroup = this.agentFormService.createAgentFormGroup();

  constructor(
    protected agentService: AgentService,
    protected agentFormService: AgentFormService,
    protected queueTerminalService: QueueTerminalService,
    protected queueDepartmentService: QueueDepartmentService,
    protected activatedRoute: ActivatedRoute,
  ) {}

  compareQueueTerminal = (o1: IQueueTerminal | null, o2: IQueueTerminal | null): boolean =>
    this.queueTerminalService.compareQueueTerminal(o1, o2);

  compareQueueDepartment = (o1: IQueueDepartment | null, o2: IQueueDepartment | null): boolean =>
    this.queueDepartmentService.compareQueueDepartment(o1, o2);

  ngOnInit(): void {
    this.activatedRoute.data.subscribe(({ agent }) => {
      this.agent = agent;
      if (agent) {
        this.updateForm(agent);
      }

      this.loadRelationshipsOptions();
    });
  }

  previousState(): void {
    window.history.back();
  }

  save(): void {
    this.isSaving = true;
    const agent = this.agentFormService.getAgent(this.editForm);
    if (agent.id !== null) {
      this.subscribeToSaveResponse(this.agentService.update(agent));
    } else {
      this.subscribeToSaveResponse(this.agentService.create(agent));
    }
  }

  protected subscribeToSaveResponse(result: Observable<HttpResponse<IAgent>>): void {
    result.pipe(finalize(() => this.onSaveFinalize())).subscribe({
      next: () => this.onSaveSuccess(),
      error: () => this.onSaveError(),
    });
  }

  protected onSaveSuccess(): void {
    this.previousState();
  }

  protected onSaveError(): void {
    // Api for inheritance.
  }

  protected onSaveFinalize(): void {
    this.isSaving = false;
  }

  protected updateForm(agent: IAgent): void {
    this.agent = agent;
    this.agentFormService.resetForm(this.editForm, agent);

    this.queueTerminalsSharedCollection = this.queueTerminalService.addQueueTerminalToCollectionIfMissing<IQueueTerminal>(
      this.queueTerminalsSharedCollection,
      agent.queueTerminal,
    );
    this.queueDepartmentsSharedCollection = this.queueDepartmentService.addQueueDepartmentToCollectionIfMissing<IQueueDepartment>(
      this.queueDepartmentsSharedCollection,
      agent.queueDepartment,
    );
  }

  protected loadRelationshipsOptions(): void {
    this.queueTerminalService
      .query()
      .pipe(map((res: HttpResponse<IQueueTerminal[]>) => res.body ?? []))
      .pipe(
        map((queueTerminals: IQueueTerminal[]) =>
          this.queueTerminalService.addQueueTerminalToCollectionIfMissing<IQueueTerminal>(queueTerminals, this.agent?.queueTerminal),
        ),
      )
      .subscribe((queueTerminals: IQueueTerminal[]) => (this.queueTerminalsSharedCollection = queueTerminals));

    this.queueDepartmentService
      .query()
      .pipe(map((res: HttpResponse<IQueueDepartment[]>) => res.body ?? []))
      .pipe(
        map((queueDepartments: IQueueDepartment[]) =>
          this.queueDepartmentService.addQueueDepartmentToCollectionIfMissing<IQueueDepartment>(
            queueDepartments,
            this.agent?.queueDepartment,
          ),
        ),
      )
      .subscribe((queueDepartments: IQueueDepartment[]) => (this.queueDepartmentsSharedCollection = queueDepartments));
  }
}
