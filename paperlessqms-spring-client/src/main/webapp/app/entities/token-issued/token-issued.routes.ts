import { Routes } from '@angular/router';

import { UserRouteAccessService } from 'app/core/auth/user-route-access.service';
import { ASC } from 'app/config/navigation.constants';
import { TokenIssuedComponent } from './list/token-issued.component';
import { TokenIssuedDetailComponent } from './detail/token-issued-detail.component';
import { TokenIssuedUpdateComponent } from './update/token-issued-update.component';
import TokenIssuedResolve from './route/token-issued-routing-resolve.service';

const tokenIssuedRoute: Routes = [
  {
    path: '',
    component: TokenIssuedComponent,
    data: {
      defaultSort: 'id,' + ASC,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/view',
    component: TokenIssuedDetailComponent,
    resolve: {
      tokenIssued: TokenIssuedResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: 'new',
    component: TokenIssuedUpdateComponent,
    resolve: {
      tokenIssued: TokenIssuedResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/edit',
    component: TokenIssuedUpdateComponent,
    resolve: {
      tokenIssued: TokenIssuedResolve,
    },
    canActivate: [UserRouteAccessService],
  },
];

export default tokenIssuedRoute;
