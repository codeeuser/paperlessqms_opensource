import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';

import SharedModule from 'app/shared/shared.module';
import { ITEM_DELETED_EVENT } from 'app/config/navigation.constants';
import { IQueueDepartment } from '../queue-department.model';
import { QueueDepartmentService } from '../service/queue-department.service';

@Component({
  standalone: true,
  templateUrl: './queue-department-delete-dialog.component.html',
  imports: [SharedModule, FormsModule],
})
export class QueueDepartmentDeleteDialogComponent {
  queueDepartment?: IQueueDepartment;

  constructor(
    protected queueDepartmentService: QueueDepartmentService,
    protected activeModal: NgbActiveModal,
  ) {}

  cancel(): void {
    this.activeModal.dismiss();
  }

  confirmDelete(id: number): void {
    this.queueDepartmentService.delete(id).subscribe(() => {
      this.activeModal.close(ITEM_DELETED_EVENT);
    });
  }
}
