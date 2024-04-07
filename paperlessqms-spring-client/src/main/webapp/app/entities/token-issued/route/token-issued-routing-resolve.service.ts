import { inject } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRouteSnapshot, Router } from '@angular/router';
import { of, EMPTY, Observable } from 'rxjs';
import { mergeMap } from 'rxjs/operators';

import { ITokenIssued } from '../token-issued.model';
import { TokenIssuedService } from '../service/token-issued.service';

export const tokenIssuedResolve = (route: ActivatedRouteSnapshot): Observable<null | ITokenIssued> => {
  const id = route.params['id'];
  if (id) {
    return inject(TokenIssuedService)
      .find(id)
      .pipe(
        mergeMap((tokenIssued: HttpResponse<ITokenIssued>) => {
          if (tokenIssued.body) {
            return of(tokenIssued.body);
          } else {
            inject(Router).navigate(['404']);
            return EMPTY;
          }
        }),
      );
  }
  return of(null);
};

export default tokenIssuedResolve;
