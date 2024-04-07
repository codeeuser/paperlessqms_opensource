import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';

import SharedModule from 'app/shared/shared.module';
import { ITEM_DELETED_EVENT } from 'app/config/navigation.constants';
import { ITokenIssued } from '../token-issued.model';
import { TokenIssuedService } from '../service/token-issued.service';

@Component({
  standalone: true,
  templateUrl: './token-issued-delete-dialog.component.html',
  imports: [SharedModule, FormsModule],
})
export class TokenIssuedDeleteDialogComponent {
  tokenIssued?: ITokenIssued;

  constructor(
    protected tokenIssuedService: TokenIssuedService,
    protected activeModal: NgbActiveModal,
  ) {}

  cancel(): void {
    this.activeModal.dismiss();
  }

  confirmDelete(id: number): void {
    this.tokenIssuedService.delete(id).subscribe(() => {
      this.activeModal.close(ITEM_DELETED_EVENT);
    });
  }
}
