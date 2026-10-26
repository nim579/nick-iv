<template>
  <main class="error">
    <p class="error__code">
      404
    </p>
    <h1 class="error__title">
      Page not found
    </h1>
    <p class="error__text">
      This page does not exist, or it moved somewhere else.
    </p>
    <Btn href="/">
      Back to the main page
    </Btn>
  </main>
</template>

<script setup>
import { useHead } from '@unhead/vue';

import Btn from '../components/Btn.vue';

useHead({
  title: 'Page not found — Nick Iv',
  meta: [{ name: 'robots', content: 'noindex' }]
});
</script>

<style lang="scss" scoped>
.error {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  min-height: 100vh;
  min-height: 100dvh;
  padding: var(--gutter);

  text-align: center;

  &__code {
    font-size: var(--fs-display);
    font-weight: 600;
    line-height: 1;
    letter-spacing: -0.04em;
    color: var(--color-secondary);
  }

  &__title {
    margin-top: 12px;
    font-size: var(--fs-h2);
    font-weight: 600;
    letter-spacing: -0.03em;
  }

  &__text {
    margin: 12px 0 32px;
    font-size: var(--fs-lead);
    color: var(--color-secondary);
  }
}
</style>
