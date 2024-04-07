import { Routes } from '@angular/router';

import { UserRouteAccessService } from 'app/core/auth/user-route-access.service';
import { ASC } from 'app/config/navigation.constants';
import { QueueServiceComponent } from './list/queue-service.component';
import { QueueServiceDetailComponent } from './detail/queue-service-detail.component';
import { QueueServiceUpdateComponent } from './update/queue-service-update.component';
import QueueServiceResolve from './route/queue-service-routing-resolve.service';

const queueServiceRoute: Routes = [
  {
    path: '',
    component: QueueServiceComponent,
    data: {
      defaultSort: 'id,' + ASC,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/view',
    component: QueueServiceDetailComponent,
    resolve: {
      queueService: QueueServiceResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: 'new',
    component: QueueServiceUpdateComponent,
    resolve: {
      queueService: QueueServiceResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/edit',
    component: QueueServiceUpdateComponent,
    resolve: {
      queueService: QueueServiceResolve,
    },
    canActivate: [UserRouteAccessService],
  },
];

export default queueServiceRoute;
