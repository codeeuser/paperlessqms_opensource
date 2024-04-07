import { Routes } from '@angular/router';

import { UserRouteAccessService } from 'app/core/auth/user-route-access.service';
import { ASC } from 'app/config/navigation.constants';
import { QueueDepartmentComponent } from './list/queue-department.component';
import { QueueDepartmentDetailComponent } from './detail/queue-department-detail.component';
import { QueueDepartmentUpdateComponent } from './update/queue-department-update.component';
import QueueDepartmentResolve from './route/queue-department-routing-resolve.service';

const queueDepartmentRoute: Routes = [
  {
    path: '',
    component: QueueDepartmentComponent,
    data: {
      defaultSort: 'id,' + ASC,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/view',
    component: QueueDepartmentDetailComponent,
    resolve: {
      queueDepartment: QueueDepartmentResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: 'new',
    component: QueueDepartmentUpdateComponent,
    resolve: {
      queueDepartment: QueueDepartmentResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/edit',
    component: QueueDepartmentUpdateComponent,
    resolve: {
      queueDepartment: QueueDepartmentResolve,
    },
    canActivate: [UserRouteAccessService],
  },
];

export default queueDepartmentRoute;
