import { inject } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRouteSnapshot, Router } from '@angular/router';
import { of, EMPTY, Observable } from 'rxjs';
import { mergeMap } from 'rxjs/operators';

import { IQueueDepartment } from '../queue-department.model';
import { QueueDepartmentService } from '../service/queue-department.service';

export const queueDepartmentResolve = (route: ActivatedRouteSnapshot): Observable<null | IQueueDepartment> => {
  const id = route.params['id'];
  if (id) {
    return inject(QueueDepartmentService)
      .find(id)
      .pipe(
        mergeMap((queueDepartment: HttpResponse<IQueueDepartment>) => {
          if (queueDepartment.body) {
            return of(queueDepartment.body);
          } else {
            inject(Router).navigate(['404']);
            return EMPTY;
          }
        }),
      );
  }
  return of(null);
};

export default queueDepartmentResolve;
