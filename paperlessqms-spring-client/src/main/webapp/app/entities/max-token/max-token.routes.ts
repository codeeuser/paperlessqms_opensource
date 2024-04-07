import { Routes } from '@angular/router';

import { UserRouteAccessService } from 'app/core/auth/user-route-access.service';
import { ASC } from 'app/config/navigation.constants';
import { MaxTokenComponent } from './list/max-token.component';
import { MaxTokenDetailComponent } from './detail/max-token-detail.component';
import { MaxTokenUpdateComponent } from './update/max-token-update.component';
import MaxTokenResolve from './route/max-token-routing-resolve.service';

const maxTokenRoute: Routes = [
  {
    path: '',
    component: MaxTokenComponent,
    data: {
      defaultSort: 'id,' + ASC,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/view',
    component: MaxTokenDetailComponent,
    resolve: {
      maxToken: MaxTokenResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: 'new',
    component: MaxTokenUpdateComponent,
    resolve: {
      maxToken: MaxTokenResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/edit',
    component: MaxTokenUpdateComponent,
    resolve: {
      maxToken: MaxTokenResolve,
    },
    canActivate: [UserRouteAccessService],
  },
];

export default maxTokenRoute;
