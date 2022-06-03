import { createApp } from './index';
import { renderToString } from 'vue/server-renderer';
import { basename, extname } from 'path';
import { renderHeadToString } from '@vueuse/head';

export const render = async (url, manifest) => {
  const { app, router, head } = createApp(true);

  router.push(url);
  await router.isReady();

  const ctx = {};
  const html = await renderToString(app, ctx);
  const meta = await renderHeadToString(head);

  const links = renderPreloadLinks(ctx.modules, manifest);

  return { html, ctx, meta, links };
};

function renderPreloadLinks(modules, manifest) {
  let links = '';
  const seen = new Set();
  modules.forEach((id) => {
    const files = manifest[id];
    if (files) {
      files.forEach((file) => {
        if (!seen.has(file)) {
          seen.add(file);
          const filename = basename(file);
          if (manifest[filename]) {
            for (const depFile of manifest[filename]) {
              links += renderPreloadLink(depFile);
              seen.add(depFile);
            }
          }
          links += renderPreloadLink(file);
        }
      });
    }
  });
  return links;
}

function renderPreloadLink(file) {
  switch (extname(file).toLowerCase()) {
  case '.js':
    return `<link rel="modulepreload" crossorigin href="${file}">`;
  case '.css':
    return `<link rel="stylesheet" href="${file}">`;
  case '.woff':
    return `<link rel="preload" href="${file}" as="font" type="font/woff" crossorigin>`;
  case '.woff2':
    return `<link rel="preload" href="${file}" as="font" type="font/woff2" crossorigin>`;
  case '.gif':
    return `<link rel="preload" href="${file}" as="image" type="image/gif">`;
  case '.jpg':
  case '.jpeg':
    return `<link rel="preload" href="${file}" as="image" type="image/jpeg">`;
  case '.png':
    return `<link rel="preload" href="${file}" as="image" type="image/png">`;
  default:
    return '';
  }
}

