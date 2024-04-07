import { Routes } from '@angular/router';

const routes: Routes = [
  {
    path: 'profile-biz',
    data: { pageTitle: 'paperlessqmsApp.profileBiz.home.title' },
    loadChildren: () => import('./profile-biz/profile-biz.routes'),
  },
  {
    path: 'queue-department',
    data: { pageTitle: 'paperlessqmsApp.queueDepartment.home.title' },
    loadChildren: () => import('./queue-department/queue-department.routes'),
  },
  {
    path: 'queue-terminal',
    data: { pageTitle: 'paperlessqmsApp.queueTerminal.home.title' },
    loadChildren: () => import('./queue-terminal/queue-terminal.routes'),
  },
  {
    path: 'queue-service',
    data: { pageTitle: 'paperlessqmsApp.queueService.home.title' },
    loadChildren: () => import('./queue-service/queue-service.routes'),
  },
  {
    path: 'agent',
    data: { pageTitle: 'paperlessqmsApp.agent.home.title' },
    loadChildren: () => import('./agent/agent.routes'),
  },
  {
    path: 'token-issued',
    data: { pageTitle: 'paperlessqmsApp.tokenIssued.home.title' },
    loadChildren: () => import('./token-issued/token-issued.routes'),
  },
  {
    path: 'token-number',
    data: { pageTitle: 'paperlessqmsApp.tokenNumber.home.title' },
    loadChildren: () => import('./token-number/token-number.routes'),
  },
  {
    path: 'max-token',
    data: { pageTitle: 'paperlessqmsApp.maxToken.home.title' },
    loadChildren: () => import('./max-token/max-token.routes'),
  },
  {
    path: 'open-hour',
    data: { pageTitle: 'paperlessqmsApp.openHour.home.title' },
    loadChildren: () => import('./open-hour/open-hour.routes'),
  },
  /* jhipster-needle-add-entity-route - JHipster will add entity modules routes here */
];

export default routes;
