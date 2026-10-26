# [nick-iv.me](https://nick-iv.me)

Personal site. Vue 3, Vite, SCSS, prerendered with [vite-ssg](https://github.com/antfu-collective/vite-ssg) and served by nginx.

Requires Node.js 20.19 or newer.

## Develop

``` shell
npm install
npm start
```

## Build

``` shell
npm run build:prod
```

Static site in `dist/` (`index.html` and `404.html`). `npm run lint` runs ESLint.

## Content

Everything on the page lives in [`src/data/site.js`](src/data/site.js): menu, stats, projects, open source cards.
Sections are in `src/sections/`.

## Images

Source images are PNG files in `assets/images/`. The site uses their AVIF and WebP versions:

``` shell
npm run images
```

The script generates `.avif` and `.webp` next to each PNG. Commit the result.

- Screenshots of the projects live in `assets/images/projects/`, 1440x900.
- Open source illustrations are SVG files in `assets/images/oss/`. They use `currentColor`, and the classes
  `ac` (accent), `bg` (tile background) and `up`, `tl`, `k1` and so on (hover animation).
- The social preview `assets/images/sharing.png` is rendered from `scripts/sharing.html`, see the comment inside.

## Deploy

Every push to `master` runs `.github/workflows/deploy.yml`: it connects to the server over ssh, pulls the repository
and runs `docker compose up -d --build` (see `scripts/deploy`). Other branches and pull requests only run
`.github/workflows/check.yml` (lint and build).
