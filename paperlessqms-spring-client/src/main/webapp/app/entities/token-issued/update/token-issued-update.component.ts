import { Component, OnInit } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRoute } from '@angular/router';
import { Observable } from 'rxjs';
import { finalize } from 'rxjs/operators';

import SharedModule from 'app/shared/shared.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { ITokenIssued } from '../token-issued.model';
import { TokenIssuedService } from '../service/token-issued.service';
import { TokenIssuedFormService, TokenIssuedFormGroup } from './token-issued-form.service';

@Component({
  standalone: true,
  selector: 'qms-token-issued-update',
  templateUrl: './token-issued-update.component.html',
  imports: [SharedModule, FormsModule, ReactiveFormsModule],
})
export class TokenIssuedUpdateComponent implements OnInit {
  isSaving = false;
  tokenIssued: ITokenIssued | null = null;

  editForm: TokenIssuedFormGroup = this.tokenIssuedFormService.createTokenIssuedFormGroup();

  constructor(
    protected tokenIssuedService: TokenIssuedService,
    protected tokenIssuedFormService: TokenIssuedFormService,
    protected activatedRoute: ActivatedRoute,
  ) {}

  ngOnInit(): void {
    this.activatedRoute.data.subscribe(({ tokenIssued }) => {
      this.tokenIssued = tokenIssued;
      if (tokenIssued) {
        this.updateForm(tokenIssued);
      }
    });
  }

  previousState(): void {
    window.history.back();
  }

  save(): void {
    this.isSaving = true;
    const tokenIssued = this.tokenIssuedFormService.getTokenIssued(this.editForm);
    if (tokenIssued.id !== null) {
      this.subscribeToSaveResponse(this.tokenIssuedService.update(tokenIssued));
    } else {
      this.subscribeToSaveResponse(this.tokenIssuedService.create(tokenIssued));
    }
  }

  protected subscribeToSaveResponse(result: Observable<HttpResponse<ITokenIssued>>): void {
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

  protected updateForm(tokenIssued: ITokenIssued): void {
    this.tokenIssued = tokenIssued;
    this.tokenIssuedFormService.resetForm(this.editForm, tokenIssued);
  }
}
