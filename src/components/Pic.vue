<template>
  <picture>
    <template v-if="dark">
      <source v-if="dark.avif" type="image/avif" media="(prefers-color-scheme: dark)" :srcset="dark.avif">
      <source type="image/webp" media="(prefers-color-scheme: dark)" :srcset="dark.webp">
    </template>
    <source v-if="src.avif" type="image/avif" :srcset="src.avif">
    <img
      :src="src.webp"
      :alt="alt"
      :width="width"
      :height="height"
      :loading="eager ? 'eager' : 'lazy'"
      decoding="async"
    >
  </picture>
</template>

<script setup>
// Responsive picture: AVIF with WebP fallback, optional dark-mode variant
// that is chosen by CSS media query (no JS, no flash on hydration).
defineProps({
  src: { type: Object, required: true },
  dark: { type: Object, default: null },
  alt: { type: String, default: '' },
  width: { type: Number, default: undefined },
  height: { type: Number, default: undefined },
  eager: { type: Boolean, default: false }
});
</script>
