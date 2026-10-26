<template>
  <header class="head">
    <p v-if="kicker" class="head__kicker">
      {{ kicker }}
    </p>
    <h2 :id="id" class="head__title">
      {{ title }}
      <span v-if="subtitle" class="head__subtitle">{{ subtitle }}</span>
    </h2>
    <p v-if="$slots.default" class="head__text">
      <slot />
    </p>
  </header>
</template>

<script setup>
defineProps({
  id: { type: String, default: undefined },
  kicker: { type: String, default: '' },
  title: { type: String, required: true },
  subtitle: { type: String, default: '' }
});
</script>

<style lang="scss" scoped>
.head {
  max-width: 760px;

  &__kicker {
    margin-bottom: 16px;

    font-size: var(--fs-small);
    font-weight: 600;
    letter-spacing: 0.08em;
    text-transform: uppercase;
    color: var(--color-secondary);
  }

  &__title {
    font-size: var(--fs-h2);
    font-weight: 600;
    line-height: 1.06;
    letter-spacing: -0.03em;
    text-wrap: balance;
  }

  &__subtitle {
    color: var(--color-secondary);
  }

  &__text {
    margin-top: 20px;

    font-size: var(--fs-lead);
    line-height: 1.45;
    color: var(--color-secondary);
    text-wrap: pretty;
  }
}
</style>
