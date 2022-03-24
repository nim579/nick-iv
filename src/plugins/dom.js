import forEach from 'lodash/forEach';
import mapValues from 'lodash/mapValues';
import assign from 'lodash/assign';
import keys from 'lodash/keys';

import { reactive, readonly } from 'vue';

export const screens = {
  desktop: 1900,
  medium: 1200,
  mobile: 680
};

export const match = (request, callback) => {
  if (typeof window == 'undefined') return;
  if (!window.matchMedia) return;

  const matcher = window.matchMedia(request);

  const listener = () => {
    callback(matcher.matches);
  };

  setTimeout(() => listener(), 0);

  const ev = readonly({
    start() { matcher.addEventListener('change', listener); },
    stop() { matcher.removeEventListener('change', listener); },
    matcher: matcher
  });

  ev.start();

  return ev;
};

export const watchScreens = () => {
  const _data = {};
  const listeners = {};

  keys(screens).forEach(name => {
    _data[name] = false;
  });

  const data = reactive(mapValues(screens, () => false));

  forEach(screens, (size, name) => {
    const listener = match(`(max-width: ${size}px)`, matches => data[name] = matches);
    if (listener) listeners[name] = listener;
  });

  return { data: readonly(data), listeners };
};

export const watchColorScheme = () => {
  const data = reactive({ darkmode: false });
  const listeners = {};

  const listener = match('(prefers-color-scheme: dark)', matches => data.darkmode = matches);
  if (listener) listeners.darkmode = listener;

  return { data: readonly(data), listeners };
};

export default app => {
  const { data: screens, listeners: screensListeners } = watchScreens();
  const { data: colorScheme, listeners: colorSchemeListeners } = watchColorScheme();
  const listeners = readonly(assign(screensListeners, colorSchemeListeners));

  app.config.globalProperties.$dom = readonly({
    screens, colorScheme, listeners, match
  });
};
