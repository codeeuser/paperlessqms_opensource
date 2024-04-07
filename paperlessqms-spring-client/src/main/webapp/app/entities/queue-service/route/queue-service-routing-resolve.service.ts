import { inject } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRouteSnapshot, Router } from '@angular/router';
import { of, EMPTY, Observable } from 'rxjs';
import { mergeMap } from 'rxjs/operators';

import { IQueueService } from '../queue-service.model';
import { QueueServiceService } from '../service/queue-service.service';

export const queueServiceResolve = (route: ActivatedRouteSnapshot): Observable<null | IQueueService> => {
  const id = route.params['id'];
  if (id) {
    return inject(QueueServiceService)
      .find(id)
      .pipe(
        mergeMap((queueService: HttpResponse<IQueueService>) => {
          if (queueService.body) {
            return of(queueService.body);
          } else {
            inject(Router).navigate(['404']);
            return EMPTY;
          }
        }),
      );
  }
  return of(null);
};

export default queueServiceResolve;
