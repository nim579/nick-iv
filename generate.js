const fs = require('fs');
const path = require('path');

const toAbsolute = (p) => path.resolve(__dirname, p);

const manifest = require('./dist/client/ssr-manifest.json');
const template = fs.readFileSync(toAbsolute('dist/client/index.html'), 'utf-8');
const { render } = require('./dist/server/server.js');

// determine routes to pre-render from src/pages
const routesToPrerender = fs
  .readdirSync(toAbsolute('src/pages'))
  .map((file) => {
    const name = file.replace(/\.vue$/, '').toLowerCase();
    return name === 'main' ? '/' : `/${name}`;
  });

Promise.resolve()
  .then(async () => {
    for (const url of routesToPrerender) {
      const { html, meta, links } = await render(url, manifest);

      const result = template
        .replace('<html>', meta.htmlAttrs ? `<html ${meta.htmlAttrs}>` : '<html>')
        .replace('<body>', meta.bodyAttrs ? `<body ${meta.bodyAttrs}>` : '<body>')
        .replace('<!--meta-head-->', (meta.headTags || '') + links)
        .replace('<!--meta-body-->', meta.bodyTags || '')
        .replace('<!--app-html-->', html);

      const filePath = `dist/client${url === '/' ? '/index' : url}.html`;
      fs.writeFileSync(toAbsolute(filePath), result);

      // eslint-disable-next-line no-console
      console.log('pre-rendered:', filePath);
    }

    // done, delete ssr manifest
    fs.unlinkSync(toAbsolute('dist/client/ssr-manifest.json'));
  });

