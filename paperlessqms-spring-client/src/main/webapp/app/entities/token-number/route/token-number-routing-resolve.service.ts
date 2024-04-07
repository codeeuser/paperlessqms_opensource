import { inject } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRouteSnapshot, Router } from '@angular/router';
import { of, EMPTY, Observable } from 'rxjs';
import { mergeMap } from 'rxjs/operators';

import { ITokenNumber } from '../token-number.model';
import { TokenNumberService } from '../service/token-number.service';

export const tokenNumberResolve = (route: ActivatedRouteSnapshot): Observable<null | ITokenNumber> => {
  const id = route.params['id'];
  if (id) {
    return inject(TokenNumberService)
      .find(id)
      .pipe(
        mergeMap((tokenNumber: HttpResponse<ITokenNumber>) => {
          if (tokenNumber.body) {
            return of(tokenNumber.body);
          } else {
            inject(Router).navigate(['404']);
            return EMPTY;
          }
        }),
      );
  }
  return of(null);
};

export default tokenNumberResolve;
