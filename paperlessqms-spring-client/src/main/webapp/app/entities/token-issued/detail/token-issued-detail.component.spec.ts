import { TestBed } from '@angular/core/testing';
import { provideRouter, withComponentInputBinding } from '@angular/router';
import { RouterTestingHarness, RouterTestingModule } from '@angular/router/testing';
import { of } from 'rxjs';

import { TokenIssuedDetailComponent } from './token-issued-detail.component';

describe('TokenIssued Management Detail Component', () => {
  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [TokenIssuedDetailComponent, RouterTestingModule.withRoutes([], { bindToComponentInputs: true })],
      providers: [
        provideRouter(
          [
            {
              path: '**',
              component: TokenIssuedDetailComponent,
              resolve: { tokenIssued: () => of({ id: 123 }) },
            },
          ],
          withComponentInputBinding(),
        ),
      ],
    })
      .overrideTemplate(TokenIssuedDetailComponent, '')
      .compileComponents();
  });

  describe('OnInit', () => {
    it('Should load tokenIssued on init', async () => {
      const harness = await RouterTestingHarness.create();
      const instance = await harness.navigateByUrl('/', TokenIssuedDetailComponent);

      // THEN
      expect(instance.tokenIssued).toEqual(expect.objectContaining({ id: 123 }));
    });
  });
});
