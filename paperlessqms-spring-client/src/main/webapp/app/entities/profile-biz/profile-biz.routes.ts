import { Routes } from '@angular/router';

import { UserRouteAccessService } from 'app/core/auth/user-route-access.service';
import { ASC } from 'app/config/navigation.constants';
import { ProfileBizComponent } from './list/profile-biz.component';
import { ProfileBizDetailComponent } from './detail/profile-biz-detail.component';
import { ProfileBizUpdateComponent } from './update/profile-biz-update.component';
import ProfileBizResolve from './route/profile-biz-routing-resolve.service';

const profileBizRoute: Routes = [
  {
    path: '',
    component: ProfileBizComponent,
    data: {
      defaultSort: 'id,' + ASC,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/view',
    component: ProfileBizDetailComponent,
    resolve: {
      profileBiz: ProfileBizResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: 'new',
    component: ProfileBizUpdateComponent,
    resolve: {
      profileBiz: ProfileBizResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/edit',
    component: ProfileBizUpdateComponent,
    resolve: {
      profileBiz: ProfileBizResolve,
    },
    canActivate: [UserRouteAccessService],
  },
];

export default profileBizRoute;
