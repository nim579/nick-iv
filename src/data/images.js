// Optimized images (see `npm run images`): every image has .avif and .webp versions.
const files = import.meta.glob('../../assets/images/**/*.{avif,webp}', {
  eager: true,
  query: '?url',
  import: 'default'
});

export const image = (name) => {
  const avif = files[`../../assets/images/${name}.avif`];
  const webp = files[`../../assets/images/${name}.webp`];

  if (!webp) throw new Error(`Image not found: ${name}`);

  return { avif, webp };
};
