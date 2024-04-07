import { TestBed } from '@angular/core/testing';
import { provideRouter, withComponentInputBinding } from '@angular/router';
import { RouterTestingHarness, RouterTestingModule } from '@angular/router/testing';
import { of } from 'rxjs';

import { OpenHourDetailComponent } from './open-hour-detail.component';

describe('OpenHour Management Detail Component', () => {
  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [OpenHourDetailComponent, RouterTestingModule.withRoutes([], { bindToComponentInputs: true })],
      providers: [
        provideRouter(
          [
            {
              path: '**',
              component: OpenHourDetailComponent,
              resolve: { openHour: () => of({ id: 123 }) },
            },
          ],
          withComponentInputBinding(),
        ),
      ],
    })
      .overrideTemplate(OpenHourDetailComponent, '')
      .compileComponents();
  });

  describe('OnInit', () => {
    it('Should load openHour on init', async () => {
      const harness = await RouterTestingHarness.create();
      const instance = await harness.navigateByUrl('/', OpenHourDetailComponent);

      // THEN
      expect(instance.openHour).toEqual(expect.objectContaining({ id: 123 }));
    });
  });
});
