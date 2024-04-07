import { Component, OnInit } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRoute } from '@angular/router';
import { Observable } from 'rxjs';
import { finalize } from 'rxjs/operators';

import SharedModule from 'app/shared/shared.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { IMaxToken } from '../max-token.model';
import { MaxTokenService } from '../service/max-token.service';
import { MaxTokenFormService, MaxTokenFormGroup } from './max-token-form.service';

@Component({
  standalone: true,
  selector: 'qms-max-token-update',
  templateUrl: './max-token-update.component.html',
  imports: [SharedModule, FormsModule, ReactiveFormsModule],
})
export class MaxTokenUpdateComponent implements OnInit {
  isSaving = false;
  maxToken: IMaxToken | null = null;

  editForm: MaxTokenFormGroup = this.maxTokenFormService.createMaxTokenFormGroup();

  constructor(
    protected maxTokenService: MaxTokenService,
    protected maxTokenFormService: MaxTokenFormService,
    protected activatedRoute: ActivatedRoute,
  ) {}

  ngOnInit(): void {
    this.activatedRoute.data.subscribe(({ maxToken }) => {
      this.maxToken = maxToken;
      if (maxToken) {
        this.updateForm(maxToken);
      }
    });
  }

  previousState(): void {
    window.history.back();
  }

  save(): void {
    this.isSaving = true;
    const maxToken = this.maxTokenFormService.getMaxToken(this.editForm);
    if (maxToken.id !== null) {
      this.subscribeToSaveResponse(this.maxTokenService.update(maxToken));
    } else {
      this.subscribeToSaveResponse(this.maxTokenService.create(maxToken));
    }
  }

  protected subscribeToSaveResponse(result: Observable<HttpResponse<IMaxToken>>): void {
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

  protected updateForm(maxToken: IMaxToken): void {
    this.maxToken = maxToken;
    this.maxTokenFormService.resetForm(this.editForm, maxToken);
  }
}
