export default [
  {
    path: '/',
    name: 'home',
    component: () => import('./pages/Home.vue')
  },
  {
    path: '/404',
    name: 'not-found-page',
    component: () => import('./pages/NotFound.vue')
  },
  {
    path: '/:pathMatch(.*)*',
    name: 'not-found',
    component: () => import('./pages/NotFound.vue')
  }
];
