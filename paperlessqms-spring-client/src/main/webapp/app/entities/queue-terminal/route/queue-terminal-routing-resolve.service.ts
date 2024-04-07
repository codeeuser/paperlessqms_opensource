import { inject } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRouteSnapshot, Router } from '@angular/router';
import { of, EMPTY, Observable } from 'rxjs';
import { mergeMap } from 'rxjs/operators';

import { IQueueTerminal } from '../queue-terminal.model';
import { QueueTerminalService } from '../service/queue-terminal.service';

export const queueTerminalResolve = (route: ActivatedRouteSnapshot): Observable<null | IQueueTerminal> => {
  const id = route.params['id'];
  if (id) {
    return inject(QueueTerminalService)
      .find(id)
      .pipe(
        mergeMap((queueTerminal: HttpResponse<IQueueTerminal>) => {
          if (queueTerminal.body) {
            return of(queueTerminal.body);
          } else {
            inject(Router).navigate(['404']);
            return EMPTY;
          }
        }),
      );
  }
  return of(null);
};

export default queueTerminalResolve;
