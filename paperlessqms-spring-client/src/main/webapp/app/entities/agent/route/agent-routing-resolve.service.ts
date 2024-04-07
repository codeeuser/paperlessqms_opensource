import { inject } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRouteSnapshot, Router } from '@angular/router';
import { of, EMPTY, Observable } from 'rxjs';
import { mergeMap } from 'rxjs/operators';

import { IAgent } from '../agent.model';
import { AgentService } from '../service/agent.service';

export const agentResolve = (route: ActivatedRouteSnapshot): Observable<null | IAgent> => {
  const id = route.params['id'];
  if (id) {
    return inject(AgentService)
      .find(id)
      .pipe(
        mergeMap((agent: HttpResponse<IAgent>) => {
          if (agent.body) {
            return of(agent.body);
          } else {
            inject(Router).navigate(['404']);
            return EMPTY;
          }
        }),
      );
  }
  return of(null);
};

export default agentResolve;
