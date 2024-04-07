import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';

import SharedModule from 'app/shared/shared.module';
import { ITEM_DELETED_EVENT } from 'app/config/navigation.constants';
import { IQueueTerminal } from '../queue-terminal.model';
import { QueueTerminalService } from '../service/queue-terminal.service';

@Component({
  standalone: true,
  templateUrl: './queue-terminal-delete-dialog.component.html',
  imports: [SharedModule, FormsModule],
})
export class QueueTerminalDeleteDialogComponent {
  queueTerminal?: IQueueTerminal;

  constructor(
    protected queueTerminalService: QueueTerminalService,
    protected activeModal: NgbActiveModal,
  ) {}

  cancel(): void {
    this.activeModal.dismiss();
  }

  confirmDelete(id: number): void {
    this.queueTerminalService.delete(id).subscribe(() => {
      this.activeModal.close(ITEM_DELETED_EVENT);
    });
  }
}
