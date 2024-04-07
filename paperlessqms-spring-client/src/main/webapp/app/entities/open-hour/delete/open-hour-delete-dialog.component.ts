import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';

import SharedModule from 'app/shared/shared.module';
import { ITEM_DELETED_EVENT } from 'app/config/navigation.constants';
import { IOpenHour } from '../open-hour.model';
import { OpenHourService } from '../service/open-hour.service';

@Component({
  standalone: true,
  templateUrl: './open-hour-delete-dialog.component.html',
  imports: [SharedModule, FormsModule],
})
export class OpenHourDeleteDialogComponent {
  openHour?: IOpenHour;

  constructor(
    protected openHourService: OpenHourService,
    protected activeModal: NgbActiveModal,
  ) {}

  cancel(): void {
    this.activeModal.dismiss();
  }

  confirmDelete(id: number): void {
    this.openHourService.delete(id).subscribe(() => {
      this.activeModal.close(ITEM_DELETED_EVENT);
    });
  }
}
