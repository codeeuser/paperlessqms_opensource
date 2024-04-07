import { TestBed } from '@angular/core/testing';
import { provideRouter, withComponentInputBinding } from '@angular/router';
import { RouterTestingHarness, RouterTestingModule } from '@angular/router/testing';
import { of } from 'rxjs';

import { TokenNumberDetailComponent } from './token-number-detail.component';

describe('TokenNumber Management Detail Component', () => {
  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [TokenNumberDetailComponent, RouterTestingModule.withRoutes([], { bindToComponentInputs: true })],
      providers: [
        provideRouter(
          [
            {
              path: '**',
              component: TokenNumberDetailComponent,
              resolve: { tokenNumber: () => of({ id: 123 }) },
            },
          ],
          withComponentInputBinding(),
        ),
      ],
    })
      .overrideTemplate(TokenNumberDetailComponent, '')
      .compileComponents();
  });

  describe('OnInit', () => {
    it('Should load tokenNumber on init', async () => {
      const harness = await RouterTestingHarness.create();
      const instance = await harness.navigateByUrl('/', TokenNumberDetailComponent);

      // THEN
      expect(instance.tokenNumber).toEqual(expect.objectContaining({ id: 123 }));
    });
  });
});
