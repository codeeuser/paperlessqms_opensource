import { Routes } from '@angular/router';

import { UserRouteAccessService } from 'app/core/auth/user-route-access.service';
import { ASC } from 'app/config/navigation.constants';
import { OpenHourComponent } from './list/open-hour.component';
import { OpenHourDetailComponent } from './detail/open-hour-detail.component';
import { OpenHourUpdateComponent } from './update/open-hour-update.component';
import OpenHourResolve from './route/open-hour-routing-resolve.service';

const openHourRoute: Routes = [
  {
    path: '',
    component: OpenHourComponent,
    data: {
      defaultSort: 'id,' + ASC,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/view',
    component: OpenHourDetailComponent,
    resolve: {
      openHour: OpenHourResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: 'new',
    component: OpenHourUpdateComponent,
    resolve: {
      openHour: OpenHourResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/edit',
    component: OpenHourUpdateComponent,
    resolve: {
      openHour: OpenHourResolve,
    },
    canActivate: [UserRouteAccessService],
  },
];

export default openHourRoute;
