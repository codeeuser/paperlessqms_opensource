import { Component, OnInit } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRoute } from '@angular/router';
import { Observable } from 'rxjs';
import { finalize } from 'rxjs/operators';

import SharedModule from 'app/shared/shared.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { AlertError } from 'app/shared/alert/alert-error.model';
import { EventManager, EventWithContent } from 'app/core/util/event-manager.service';
import { DataUtils, FileLoadError } from 'app/core/util/data-util.service';
import { ProfileBizService } from '../service/profile-biz.service';
import { IProfileBiz } from '../profile-biz.model';
import { ProfileBizFormService, ProfileBizFormGroup } from './profile-biz-form.service';

@Component({
  standalone: true,
  selector: 'qms-profile-biz-update',
  templateUrl: './profile-biz-update.component.html',
  imports: [SharedModule, FormsModule, ReactiveFormsModule],
})
export class ProfileBizUpdateComponent implements OnInit {
  isSaving = false;
  profileBiz: IProfileBiz | null = null;

  editForm: ProfileBizFormGroup = this.profileBizFormService.createProfileBizFormGroup();

  constructor(
    protected dataUtils: DataUtils,
    protected eventManager: EventManager,
    protected profileBizService: ProfileBizService,
    protected profileBizFormService: ProfileBizFormService,
    protected activatedRoute: ActivatedRoute,
  ) {}

  ngOnInit(): void {
    this.activatedRoute.data.subscribe(({ profileBiz }) => {
      this.profileBiz = profileBiz;
      if (profileBiz) {
        this.updateForm(profileBiz);
      }
    });
  }

  byteSize(base64String: string): string {
    return this.dataUtils.byteSize(base64String);
  }

  openFile(base64String: string, contentType: string | null | undefined): void {
    this.dataUtils.openFile(base64String, contentType);
  }

  setFileData(event: Event, field: string, isImage: boolean): void {
    this.dataUtils.loadFileToForm(event, this.editForm, field, isImage).subscribe({
      error: (err: FileLoadError) =>
        this.eventManager.broadcast(new EventWithContent<AlertError>('paperlessqmsApp.error', { ...err, key: 'error.file.' + err.key })),
    });
  }

  previousState(): void {
    window.history.back();
  }

  save(): void {
    this.isSaving = true;
    const profileBiz = this.profileBizFormService.getProfileBiz(this.editForm);
    if (profileBiz.id !== null) {
      this.subscribeToSaveResponse(this.profileBizService.update(profileBiz));
    } else {
      this.subscribeToSaveResponse(this.profileBizService.create(profileBiz));
    }
  }

  protected subscribeToSaveResponse(result: Observable<HttpResponse<IProfileBiz>>): void {
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

  protected updateForm(profileBiz: IProfileBiz): void {
    this.profileBiz = profileBiz;
    this.profileBizFormService.resetForm(this.editForm, profileBiz);
  }
}
