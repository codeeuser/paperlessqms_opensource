import { Component, OnInit } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRoute } from '@angular/router';
import { Observable } from 'rxjs';
import { finalize } from 'rxjs/operators';

import SharedModule from 'app/shared/shared.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { IQueueDepartment } from '../queue-department.model';
import { QueueDepartmentService } from '../service/queue-department.service';
import { QueueDepartmentFormService, QueueDepartmentFormGroup } from './queue-department-form.service';

@Component({
  standalone: true,
  selector: 'qms-queue-department-update',
  templateUrl: './queue-department-update.component.html',
  imports: [SharedModule, FormsModule, ReactiveFormsModule],
})
export class QueueDepartmentUpdateComponent implements OnInit {
  isSaving = false;
  queueDepartment: IQueueDepartment | null = null;

  editForm: QueueDepartmentFormGroup = this.queueDepartmentFormService.createQueueDepartmentFormGroup();

  constructor(
    protected queueDepartmentService: QueueDepartmentService,
    protected queueDepartmentFormService: QueueDepartmentFormService,
    protected activatedRoute: ActivatedRoute,
  ) {}

  ngOnInit(): void {
    this.activatedRoute.data.subscribe(({ queueDepartment }) => {
      this.queueDepartment = queueDepartment;
      if (queueDepartment) {
        this.updateForm(queueDepartment);
      }
    });
  }

  previousState(): void {
    window.history.back();
  }

  save(): void {
    this.isSaving = true;
    const queueDepartment = this.queueDepartmentFormService.getQueueDepartment(this.editForm);
    if (queueDepartment.id !== null) {
      this.subscribeToSaveResponse(this.queueDepartmentService.update(queueDepartment));
    } else {
      this.subscribeToSaveResponse(this.queueDepartmentService.create(queueDepartment));
    }
  }

  protected subscribeToSaveResponse(result: Observable<HttpResponse<IQueueDepartment>>): void {
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

  protected updateForm(queueDepartment: IQueueDepartment): void {
    this.queueDepartment = queueDepartment;
    this.queueDepartmentFormService.resetForm(this.editForm, queueDepartment);
  }
}
