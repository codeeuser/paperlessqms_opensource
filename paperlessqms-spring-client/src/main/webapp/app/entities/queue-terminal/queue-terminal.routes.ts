import { Routes } from '@angular/router';

import { UserRouteAccessService } from 'app/core/auth/user-route-access.service';
import { ASC } from 'app/config/navigation.constants';
import { QueueTerminalComponent } from './list/queue-terminal.component';
import { QueueTerminalDetailComponent } from './detail/queue-terminal-detail.component';
import { QueueTerminalUpdateComponent } from './update/queue-terminal-update.component';
import QueueTerminalResolve from './route/queue-terminal-routing-resolve.service';

const queueTerminalRoute: Routes = [
  {
    path: '',
    component: QueueTerminalComponent,
    data: {
      defaultSort: 'id,' + ASC,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/view',
    component: QueueTerminalDetailComponent,
    resolve: {
      queueTerminal: QueueTerminalResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: 'new',
    component: QueueTerminalUpdateComponent,
    resolve: {
      queueTerminal: QueueTerminalResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/edit',
    component: QueueTerminalUpdateComponent,
    resolve: {
      queueTerminal: QueueTerminalResolve,
    },
    canActivate: [UserRouteAccessService],
  },
];

export default queueTerminalRoute;
