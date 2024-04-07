import { TestBed } from '@angular/core/testing';
import { provideRouter, withComponentInputBinding } from '@angular/router';
import { RouterTestingHarness, RouterTestingModule } from '@angular/router/testing';
import { of } from 'rxjs';

import { QueueServiceDetailComponent } from './queue-service-detail.component';

describe('QueueService Management Detail Component', () => {
  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [QueueServiceDetailComponent, RouterTestingModule.withRoutes([], { bindToComponentInputs: true })],
      providers: [
        provideRouter(
          [
            {
              path: '**',
              component: QueueServiceDetailComponent,
              resolve: { queueService: () => of({ id: 123 }) },
            },
          ],
          withComponentInputBinding(),
        ),
      ],
    })
      .overrideTemplate(QueueServiceDetailComponent, '')
      .compileComponents();
  });

  describe('OnInit', () => {
    it('Should load queueService on init', async () => {
      const harness = await RouterTestingHarness.create();
      const instance = await harness.navigateByUrl('/', QueueServiceDetailComponent);

      // THEN
      expect(instance.queueService).toEqual(expect.objectContaining({ id: 123 }));
    });
  });
});
