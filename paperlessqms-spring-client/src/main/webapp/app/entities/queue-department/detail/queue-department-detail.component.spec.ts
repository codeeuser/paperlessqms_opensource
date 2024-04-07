import { TestBed } from '@angular/core/testing';
import { provideRouter, withComponentInputBinding } from '@angular/router';
import { RouterTestingHarness, RouterTestingModule } from '@angular/router/testing';
import { of } from 'rxjs';

import { QueueDepartmentDetailComponent } from './queue-department-detail.component';

describe('QueueDepartment Management Detail Component', () => {
  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [QueueDepartmentDetailComponent, RouterTestingModule.withRoutes([], { bindToComponentInputs: true })],
      providers: [
        provideRouter(
          [
            {
              path: '**',
              component: QueueDepartmentDetailComponent,
              resolve: { queueDepartment: () => of({ id: 123 }) },
            },
          ],
          withComponentInputBinding(),
        ),
      ],
    })
      .overrideTemplate(QueueDepartmentDetailComponent, '')
      .compileComponents();
  });

  describe('OnInit', () => {
    it('Should load queueDepartment on init', async () => {
      const harness = await RouterTestingHarness.create();
      const instance = await harness.navigateByUrl('/', QueueDepartmentDetailComponent);

      // THEN
      expect(instance.queueDepartment).toEqual(expect.objectContaining({ id: 123 }));
    });
  });
});
