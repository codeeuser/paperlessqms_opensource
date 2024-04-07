import { TestBed } from '@angular/core/testing';
import { provideRouter, withComponentInputBinding } from '@angular/router';
import { RouterTestingHarness, RouterTestingModule } from '@angular/router/testing';
import { of } from 'rxjs';

import { AgentDetailComponent } from './agent-detail.component';

describe('Agent Management Detail Component', () => {
  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AgentDetailComponent, RouterTestingModule.withRoutes([], { bindToComponentInputs: true })],
      providers: [
        provideRouter(
          [
            {
              path: '**',
              component: AgentDetailComponent,
              resolve: { agent: () => of({ id: 123 }) },
            },
          ],
          withComponentInputBinding(),
        ),
      ],
    })
      .overrideTemplate(AgentDetailComponent, '')
      .compileComponents();
  });

  describe('OnInit', () => {
    it('Should load agent on init', async () => {
      const harness = await RouterTestingHarness.create();
      const instance = await harness.navigateByUrl('/', AgentDetailComponent);

      // THEN
      expect(instance.agent).toEqual(expect.objectContaining({ id: 123 }));
    });
  });
});
