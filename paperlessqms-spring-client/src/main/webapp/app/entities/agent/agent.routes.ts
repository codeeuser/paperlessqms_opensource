import { Routes } from '@angular/router';

import { UserRouteAccessService } from 'app/core/auth/user-route-access.service';
import { ASC } from 'app/config/navigation.constants';
import { AgentComponent } from './list/agent.component';
import { AgentDetailComponent } from './detail/agent-detail.component';
import { AgentUpdateComponent } from './update/agent-update.component';
import AgentResolve from './route/agent-routing-resolve.service';

const agentRoute: Routes = [
  {
    path: '',
    component: AgentComponent,
    data: {
      defaultSort: 'id,' + ASC,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/view',
    component: AgentDetailComponent,
    resolve: {
      agent: AgentResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: 'new',
    component: AgentUpdateComponent,
    resolve: {
      agent: AgentResolve,
    },
    canActivate: [UserRouteAccessService],
  },
  {
    path: ':id/edit',
    component: AgentUpdateComponent,
    resolve: {
      agent: AgentResolve,
    },
    canActivate: [UserRouteAccessService],
  },
];

export default agentRoute;
