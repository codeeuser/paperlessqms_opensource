import { Routes } from '@angular/router';

import { UserRouteAccessService } from 'app/core/auth/user-route-access.service';
import { ASC } from 'app/config/navigation.constants';
import { TokenNumberComponent } from './list/token-number.component';
import { TokenNumberDetailComponent } from './detail/token-number-detail.component';
import { TokenNumberUpdateComponent } from './update/token-number-update.component';
import TokenNumberResolve from './route/token-number-routing-resolve.service';

const tokenNumberRoute: Routes = [
  {
    path: '',
    component: TokenNumberComponent,
    data: {
      defaultSort: 'id,' + ASC,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/view',
    component: TokenNumberDetailComponent,
    resolve: {
      tokenNumber: TokenNumberResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: 'new',
    component: TokenNumberUpdateComponent,
    resolve: {
      tokenNumber: TokenNumberResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/edit',
    component: TokenNumberUpdateComponent,
    resolve: {
      tokenNumber: TokenNumberResolve,
    },
    canActivate: [UserRouteAccessService],
  },
];

export default tokenNumberRoute;
