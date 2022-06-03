import { createApp as createVueApp } from 'vue';
import { createRouter, createWebHistory, createMemoryHistory } from 'vue-router';
import { createHead, useHead } from '@vueuse/head';

import dom from './plugins/dom';
import scroll from './plugins/scroll';
import viewport from './plugins/viewport';

import App from './App';

const Main = () => import('./pages/main');
const Page404 = () => import('./pages/404');

const metaPlugin = (app, head) => {
  app.use(head);

  app.mixin({
    created() {
      if (typeof this.$options.metaInfo !== 'function') return;
      useHead(this.$options.metaInfo.call(this));
    }
  });
};

const routes = [
  {
    path: '/',
    name: 'main',
    component: Main
  }, {
    path: '/:pathMatch(.*)*',
    name: '404',
    component: Page404
  }
];

export const createApp = (server = false) => {
  const app = createVueApp(App);

  const router = createRouter({
    history: server ? createMemoryHistory() : createWebHistory(),
    routes
  });

  const head = createHead();

  app.use(router);
  app.use(metaPlugin, head);

  app.use(dom);
  app.use(scroll);
  app.use(viewport);

  return {
    app,
    router,
    head
  };
};
