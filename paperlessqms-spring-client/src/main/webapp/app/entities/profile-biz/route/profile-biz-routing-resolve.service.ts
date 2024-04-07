import { inject } from '@angular/core';
import { HttpResponse } from '@angular/common/http';
import { ActivatedRouteSnapshot, Router } from '@angular/router';
import { of, EMPTY, Observable } from 'rxjs';
import { mergeMap } from 'rxjs/operators';

import { IProfileBiz } from '../profile-biz.model';
import { ProfileBizService } from '../service/profile-biz.service';

export const profileBizResolve = (route: ActivatedRouteSnapshot): Observable<null | IProfileBiz> => {
  const id = route.params['id'];
  if (id) {
    return inject(ProfileBizService)
      .find(id)
      .pipe(
        mergeMap((profileBiz: HttpResponse<IProfileBiz>) => {
          if (profileBiz.body) {
            return of(profileBiz.body);
          } else {
            inject(Router).navigate(['404']);
            return EMPTY;
          }
        }),
      );
  }
  return of(null);
};

export default profileBizResolve;
