import { TestBed } from '@angular/core/testing';
import { provideRouter, withComponentInputBinding } from '@angular/router';
import { RouterTestingHarness, RouterTestingModule } from '@angular/router/testing';
import { of } from 'rxjs';

import { MaxTokenDetailComponent } from './max-token-detail.component';

describe('MaxToken Management Detail Component', () => {
  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [MaxTokenDetailComponent, RouterTestingModule.withRoutes([], { bindToComponentInputs: true })],
      providers: [
        provideRouter(
          [
            {
              path: '**',
              component: MaxTokenDetailComponent,
              resolve: { maxToken: () => of({ id: 123 }) },
            },
          ],
          withComponentInputBinding(),
        ),
      ],
    })
      .overrideTemplate(MaxTokenDetailComponent, '')
      .compileComponents();
  });

  describe('OnInit', () => {
    it('Should load maxToken on init', async () => {
      const harness = await RouterTestingHarness.create();
      const instance = await harness.navigateByUrl('/', MaxTokenDetailComponent);

      // THEN
      expect(instance.maxToken).toEqual(expect.objectContaining({ id: 123 }));
    });
  });
});
