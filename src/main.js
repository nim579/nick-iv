import { ViteSSG } from 'vite-ssg';

import App from './App.vue';
import routes from './routes';
import reveal from './plugins/reveal';

import './styles/global.scss';

// vite-ssg renders the routes at build time and hydrates them on the client.
// The head manager (unhead) is created and installed by vite-ssg itself.
export const createApp = ViteSSG(
  App,
  { routes },
  ({ app }) => {
    app.use(reveal);
  }
);
