// Generates AVIF and WebP versions next to the source PNG images.
//
//   npm run images
//
// The PNG stays as the <img> fallback, the site serves AVIF/WebP via <picture>.

import { readdir, stat } from 'node:fs/promises';
import { fileURLToPath } from 'node:url';
import path from 'node:path';
import sharp from 'sharp';

const root = fileURLToPath(new URL('../assets/images/', import.meta.url));

// Source file (relative to assets/images) -> max width of the optimized copy.
// Anything not listed keeps its original size.
const widths = {
  'userpic.png': 240,
  'teletype_art_light.png': 1200,
  'teletype_art_dark.png': 1200,
  'must_art_light.png': 600,
  'must_art_dark.png': 600
};

// Social preview and the touch icon must stay PNG.
const skip = new Set(['sharing.png', 'apple-touch-icon.png']);
const defaultWidths = {
  'projects/': 1200
};

const walk = async (dir) => {
  const entries = await readdir(dir, { withFileTypes: true });
  const files = await Promise.all(entries.map(async (entry) => {
    const full = path.join(dir, entry.name);
    return entry.isDirectory() ? walk(full) : [full];
  }));
  return files.flat();
};

const widthFor = (rel) => {
  if (widths[rel]) return widths[rel];

  const prefix = Object.keys(defaultWidths).find(item => rel.startsWith(item));
  return prefix ? defaultWidths[prefix] : null;
};

const kb = async (file) => `${((await stat(file)).size / 1024).toFixed(1)} KB`;

const files = (await walk(root)).filter(file => file.endsWith('.png'));

for (const file of files) {
  const rel = path.relative(root, file);
  if (skip.has(rel)) continue;

  const base = file.replace(/\.png$/, '');
  const width = widthFor(rel);

  const make = () => {
    const img = sharp(file);
    return width ? img.resize({ width, withoutEnlargement: true }) : img;
  };

  await make().webp({ quality: 82, effort: 5 }).toFile(`${base}.webp`);
  await make().avif({ quality: 55, effort: 5 }).toFile(`${base}.avif`);

  console.log(`${rel}: png ${await kb(file)} -> webp ${await kb(`${base}.webp`)}, avif ${await kb(`${base}.avif`)}`);
}
