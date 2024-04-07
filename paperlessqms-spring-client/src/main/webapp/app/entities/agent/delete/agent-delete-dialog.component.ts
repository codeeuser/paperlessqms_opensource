import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';

import SharedModule from 'app/shared/shared.module';
import { ITEM_DELETED_EVENT } from 'app/config/navigation.constants';
import { IAgent } from '../agent.model';
import { AgentService } from '../service/agent.service';

@Component({
  standalone: true,
  templateUrl: './agent-delete-dialog.component.html',
  imports: [SharedModule, FormsModule],
})
export class AgentDeleteDialogComponent {
  agent?: IAgent;

  constructor(
    protected agentService: AgentService,
    protected activeModal: NgbActiveModal,
  ) {}

  cancel(): void {
    this.activeModal.dismiss();
  }

  confirmDelete(id: number): void {
    this.agentService.delete(id).subscribe(() => {
      this.activeModal.close(ITEM_DELETED_EVENT);
    });
  }
}
