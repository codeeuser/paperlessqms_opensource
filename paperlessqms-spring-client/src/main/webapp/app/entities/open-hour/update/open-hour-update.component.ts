import { Component, OnInit } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRoute } from '@angular/router';
import { Observable } from 'rxjs';
import { finalize } from 'rxjs/operators';

import SharedModule from 'app/shared/shared.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { IOpenHour } from '../open-hour.model';
import { OpenHourService } from '../service/open-hour.service';
import { OpenHourFormService, OpenHourFormGroup } from './open-hour-form.service';

@Component({
  standalone: true,
  selector: 'qms-open-hour-update',
  templateUrl: './open-hour-update.component.html',
  imports: [SharedModule, FormsModule, ReactiveFormsModule],
})
export class OpenHourUpdateComponent implements OnInit {
  isSaving = false;
  openHour: IOpenHour | null = null;

  editForm: OpenHourFormGroup = this.openHourFormService.createOpenHourFormGroup();

  constructor(
    protected openHourService: OpenHourService,
    protected openHourFormService: OpenHourFormService,
    protected activatedRoute: ActivatedRoute,
  ) {}

  ngOnInit(): void {
    this.activatedRoute.data.subscribe(({ openHour }) => {
      this.openHour = openHour;
      if (openHour) {
        this.updateForm(openHour);
      }
    });
  }

  previousState(): void {
    window.history.back();
  }

  save(): void {
    this.isSaving = true;
    const openHour = this.openHourFormService.getOpenHour(this.editForm);
    if (openHour.id !== null) {
      this.subscribeToSaveResponse(this.openHourService.update(openHour));
    } else {
      this.subscribeToSaveResponse(this.openHourService.create(openHour));
    }
  }

  protected subscribeToSaveResponse(result: Observable<HttpResponse<IOpenHour>>): void {
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

  protected updateForm(openHour: IOpenHour): void {
    this.openHour = openHour;
    this.openHourFormService.resetForm(this.editForm, openHour);
  }
}
