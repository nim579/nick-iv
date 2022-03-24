import { createApp } from './index';

const { app, router } = createApp();

router.isReady().then(() => {
  app.mount('body');
});

window.app = app;
