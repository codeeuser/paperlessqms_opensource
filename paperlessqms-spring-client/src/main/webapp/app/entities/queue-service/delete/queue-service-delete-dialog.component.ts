import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';

import SharedModule from 'app/shared/shared.module';
import { ITEM_DELETED_EVENT } from 'app/config/navigation.constants';
import { IQueueService } from '../queue-service.model';
import { QueueServiceService } from '../service/queue-service.service';

@Component({
  standalone: true,
  templateUrl: './queue-service-delete-dialog.component.html',
  imports: [SharedModule, FormsModule],
})
export class QueueServiceDeleteDialogComponent {
  queueService?: IQueueService;

  constructor(
    protected queueServiceService: QueueServiceService,
    protected activeModal: NgbActiveModal,
  ) {}

  cancel(): void {
    this.activeModal.dismiss();
  }

  confirmDelete(id: number): void {
    this.queueServiceService.delete(id).subscribe(() => {
      this.activeModal.close(ITEM_DELETED_EVENT);
    });
  }
}
