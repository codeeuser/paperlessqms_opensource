import { Component, OnInit } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRoute } from '@angular/router';
import { Observable } from 'rxjs';
import { finalize, map } from 'rxjs/operators';

import SharedModule from 'app/shared/shared.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { IQueueDepartment } from 'app/entities/queue-department/queue-department.model';
import { QueueDepartmentService } from 'app/entities/queue-department/service/queue-department.service';
import { IQueueTerminal } from '../queue-terminal.model';
import { QueueTerminalService } from '../service/queue-terminal.service';
import { QueueTerminalFormService, QueueTerminalFormGroup } from './queue-terminal-form.service';

@Component({
  standalone: true,
  selector: 'qms-queue-terminal-update',
  templateUrl: './queue-terminal-update.component.html',
  imports: [SharedModule, FormsModule, ReactiveFormsModule],
})
export class QueueTerminalUpdateComponent implements OnInit {
  isSaving = false;
  queueTerminal: IQueueTerminal | null = null;

  queueDepartmentsSharedCollection: IQueueDepartment[] = [];

  editForm: QueueTerminalFormGroup = this.queueTerminalFormService.createQueueTerminalFormGroup();

  constructor(
    protected queueTerminalService: QueueTerminalService,
    protected queueTerminalFormService: QueueTerminalFormService,
    protected queueDepartmentService: QueueDepartmentService,
    protected activatedRoute: ActivatedRoute,
  ) {}

  compareQueueDepartment = (o1: IQueueDepartment | null, o2: IQueueDepartment | null): boolean =>
    this.queueDepartmentService.compareQueueDepartment(o1, o2);

  ngOnInit(): void {
    this.activatedRoute.data.subscribe(({ queueTerminal }) => {
      this.queueTerminal = queueTerminal;
      if (queueTerminal) {
        this.updateForm(queueTerminal);
      }

      this.loadRelationshipsOptions();
    });
  }

  previousState(): void {
    window.history.back();
  }

  save(): void {
    this.isSaving = true;
    const queueTerminal = this.queueTerminalFormService.getQueueTerminal(this.editForm);
    if (queueTerminal.id !== null) {
      this.subscribeToSaveResponse(this.queueTerminalService.update(queueTerminal));
    } else {
      this.subscribeToSaveResponse(this.queueTerminalService.create(queueTerminal));
    }
  }

  protected subscribeToSaveResponse(result: Observable<HttpResponse<IQueueTerminal>>): void {
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

  protected updateForm(queueTerminal: IQueueTerminal): void {
    this.queueTerminal = queueTerminal;
    this.queueTerminalFormService.resetForm(this.editForm, queueTerminal);

    this.queueDepartmentsSharedCollection = this.queueDepartmentService.addQueueDepartmentToCollectionIfMissing<IQueueDepartment>(
      this.queueDepartmentsSharedCollection,
      queueTerminal.queueDepartment,
    );
  }

  protected loadRelationshipsOptions(): void {
    this.queueDepartmentService
      .query()
      .pipe(map((res: HttpResponse<IQueueDepartment[]>) => res.body ?? []))
      .pipe(
        map((queueDepartments: IQueueDepartment[]) =>
          this.queueDepartmentService.addQueueDepartmentToCollectionIfMissing<IQueueDepartment>(
            queueDepartments,
            this.queueTerminal?.queueDepartment,
          ),
        ),
      )
      .subscribe((queueDepartments: IQueueDepartment[]) => (this.queueDepartmentsSharedCollection = queueDepartments));
  }
}
