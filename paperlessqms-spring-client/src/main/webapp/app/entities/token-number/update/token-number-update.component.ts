import { Component, OnInit } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRoute } from '@angular/router';
import { Observable } from 'rxjs';
import { finalize } from 'rxjs/operators';

import SharedModule from 'app/shared/shared.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { ITokenNumber } from '../token-number.model';
import { TokenNumberService } from '../service/token-number.service';
import { TokenNumberFormService, TokenNumberFormGroup } from './token-number-form.service';

@Component({
  standalone: true,
  selector: 'qms-token-number-update',
  templateUrl: './token-number-update.component.html',
  imports: [SharedModule, FormsModule, ReactiveFormsModule],
})
export class TokenNumberUpdateComponent implements OnInit {
  isSaving = false;
  tokenNumber: ITokenNumber | null = null;

  editForm: TokenNumberFormGroup = this.tokenNumberFormService.createTokenNumberFormGroup();

  constructor(
    protected tokenNumberService: TokenNumberService,
    protected tokenNumberFormService: TokenNumberFormService,
    protected activatedRoute: ActivatedRoute,
  ) {}

  ngOnInit(): void {
    this.activatedRoute.data.subscribe(({ tokenNumber }) => {
      this.tokenNumber = tokenNumber;
      if (tokenNumber) {
        this.updateForm(tokenNumber);
      }
    });
  }

  previousState(): void {
    window.history.back();
  }

  save(): void {
    this.isSaving = true;
    const tokenNumber = this.tokenNumberFormService.getTokenNumber(this.editForm);
    if (tokenNumber.id !== null) {
      this.subscribeToSaveResponse(this.tokenNumberService.update(tokenNumber));
    } else {
      this.subscribeToSaveResponse(this.tokenNumberService.create(tokenNumber));
    }
  }

  protected subscribeToSaveResponse(result: Observable<HttpResponse<ITokenNumber>>): void {
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

  protected updateForm(tokenNumber: ITokenNumber): void {
    this.tokenNumber = tokenNumber;
    this.tokenNumberFormService.resetForm(this.editForm, tokenNumber);
  }
}
