import { TestBed } from '@angular/core/testing';
import { provideRouter, withComponentInputBinding } from '@angular/router';
import { RouterTestingHarness, RouterTestingModule } from '@angular/router/testing';
import { of } from 'rxjs';

import { QueueTerminalDetailComponent } from './queue-terminal-detail.component';

describe('QueueTerminal Management Detail Component', () => {
  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [QueueTerminalDetailComponent, RouterTestingModule.withRoutes([], { bindToComponentInputs: true })],
      providers: [
        provideRouter(
          [
            {
              path: '**',
              component: QueueTerminalDetailComponent,
              resolve: { queueTerminal: () => of({ id: 123 }) },
            },
          ],
          withComponentInputBinding(),
        ),
      ],
    })
      .overrideTemplate(QueueTerminalDetailComponent, '')
      .compileComponents();
  });

  describe('OnInit', () => {
    it('Should load queueTerminal on init', async () => {
      const harness = await RouterTestingHarness.create();
      const instance = await harness.navigateByUrl('/', QueueTerminalDetailComponent);

      // THEN
      expect(instance.queueTerminal).toEqual(expect.objectContaining({ id: 123 }));
    });
  });
});
