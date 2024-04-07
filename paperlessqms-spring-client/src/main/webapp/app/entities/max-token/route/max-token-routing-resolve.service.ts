import { inject } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRouteSnapshot, Router } from '@angular/router';
import { of, EMPTY, Observable } from 'rxjs';
import { mergeMap } from 'rxjs/operators';

import { IMaxToken } from '../max-token.model';
import { MaxTokenService } from '../service/max-token.service';

export const maxTokenResolve = (route: ActivatedRouteSnapshot): Observable<null | IMaxToken> => {
  const id = route.params['id'];
  if (id) {
    return inject(MaxTokenService)
      .find(id)
      .pipe(
        mergeMap((maxToken: HttpResponse<IMaxToken>) => {
          if (maxToken.body) {
            return of(maxToken.body);
          } else {
            inject(Router).navigate(['404']);
            return EMPTY;
          }
        }),
      );
  }
  return of(null);
};

export default maxTokenResolve;
