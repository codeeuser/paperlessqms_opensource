import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';

import SharedModule from 'app/shared/shared.module';
import { ITEM_DELETED_EVENT } from 'app/config/navigation.constants';
import { ITokenNumber } from '../token-number.model';
import { TokenNumberService } from '../service/token-number.service';

@Component({
  standalone: true,
  templateUrl: './token-number-delete-dialog.component.html',
  imports: [SharedModule, FormsModule],
})
export class TokenNumberDeleteDialogComponent {
  tokenNumber?: ITokenNumber;

  constructor(
    protected tokenNumberService: TokenNumberService,
    protected activeModal: NgbActiveModal,
  ) {}

  cancel(): void {
    this.activeModal.dismiss();
  }

  confirmDelete(id: number): void {
    this.tokenNumberService.delete(id).subscribe(() => {
      this.activeModal.close(ITEM_DELETED_EVENT);
    });
  }
}
