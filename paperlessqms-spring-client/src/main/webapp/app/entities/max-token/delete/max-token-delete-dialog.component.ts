import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';

import SharedModule from 'app/shared/shared.module';
import { ITEM_DELETED_EVENT } from 'app/config/navigation.constants';
import { IMaxToken } from '../max-token.model';
import { MaxTokenService } from '../service/max-token.service';

@Component({
  standalone: true,
  templateUrl: './max-token-delete-dialog.component.html',
  imports: [SharedModule, FormsModule],
})
export class MaxTokenDeleteDialogComponent {
  maxToken?: IMaxToken;

  constructor(
    protected maxTokenService: MaxTokenService,
    protected activeModal: NgbActiveModal,
  ) {}

  cancel(): void {
    this.activeModal.dismiss();
  }

  confirmDelete(id: number): void {
    this.maxTokenService.delete(id).subscribe(() => {
      this.activeModal.close(ITEM_DELETED_EVENT);
    });
  }
}
