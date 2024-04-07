import { Component, OnInit } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRoute } from '@angular/router';
import { Observable } from 'rxjs';
import { finalize, map } from 'rxjs/operators';

import SharedModule from 'app/shared/shared.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { IQueueDepartment } from 'app/entities/queue-department/queue-department.model';
import { QueueDepartmentService } from 'app/entities/queue-department/service/queue-department.service';
import { IQueueService } from '../queue-service.model';
import { QueueServiceService } from '../service/queue-service.service';
import { QueueServiceFormService, QueueServiceFormGroup } from './queue-service-form.service';

@Component({
  standalone: true,
  selector: 'qms-queue-service-update',
  templateUrl: './queue-service-update.component.html',
  imports: [SharedModule, FormsModule, ReactiveFormsModule],
})
export class QueueServiceUpdateComponent implements OnInit {
  isSaving = false;
  queueService: IQueueService | null = null;

  queueDepartmentsSharedCollection: IQueueDepartment[] = [];

  editForm: QueueServiceFormGroup = this.queueServiceFormService.createQueueServiceFormGroup();

  constructor(
    protected queueServiceService: QueueServiceService,
    protected queueServiceFormService: QueueServiceFormService,
    protected queueDepartmentService: QueueDepartmentService,
    protected activatedRoute: ActivatedRoute,
  ) {}

  compareQueueDepartment = (o1: IQueueDepartment | null, o2: IQueueDepartment | null): boolean =>
    this.queueDepartmentService.compareQueueDepartment(o1, o2);

  ngOnInit(): void {
    this.activatedRoute.data.subscribe(({ queueService }) => {
      this.queueService = queueService;
      if (queueService) {
        this.updateForm(queueService);
      }

      this.loadRelationshipsOptions();
    });
  }

  previousState(): void {
    window.history.back();
  }

  save(): void {
    this.isSaving = true;
    const queueService = this.queueServiceFormService.getQueueService(this.editForm);
    if (queueService.id !== null) {
      this.subscribeToSaveResponse(this.queueServiceService.update(queueService));
    } else {
      this.subscribeToSaveResponse(this.queueServiceService.create(queueService));
    }
  }

  protected subscribeToSaveResponse(result: Observable<HttpResponse<IQueueService>>): void {
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

  protected updateForm(queueService: IQueueService): void {
    this.queueService = queueService;
    this.queueServiceFormService.resetForm(this.editForm, queueService);

    this.queueDepartmentsSharedCollection = this.queueDepartmentService.addQueueDepartmentToCollectionIfMissing<IQueueDepartment>(
      this.queueDepartmentsSharedCollection,
      queueService.queueDepartment,
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
            this.queueService?.queueDepartment,
          ),
        ),
      )
      .subscribe((queueDepartments: IQueueDepartment[]) => (this.queueDepartmentsSharedCollection = queueDepartments));
  }
}
