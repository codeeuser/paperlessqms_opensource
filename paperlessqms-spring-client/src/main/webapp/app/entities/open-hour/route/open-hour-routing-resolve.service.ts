import { inject } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRouteSnapshot, Router } from '@angular/router';
import { of, EMPTY, Observable } from 'rxjs';
import { mergeMap } from 'rxjs/operators';

import { IOpenHour } from '../open-hour.model';
import { OpenHourService } from '../service/open-hour.service';

export const openHourResolve = (route: ActivatedRouteSnapshot): Observable<null | IOpenHour> => {
  const id = route.params['id'];
  if (id) {
    return inject(OpenHourService)
      .find(id)
      .pipe(
        mergeMap((openHour: HttpResponse<IOpenHour>) => {
          if (openHour.body) {
            return of(openHour.body);
          } else {
            inject(Router).navigate(['404']);
            return EMPTY;
          }
        }),
      );
  }
  return of(null);
};

export default openHourResolve;
