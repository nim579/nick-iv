<template>
  <ul class="stats">
    <li v-for="item in items" :key="item.label" class="stats__item">
      <span class="stats__value">{{ item.value }}</span>
      <span class="stats__label">{{ item.label }}</span>
    </li>
  </ul>
</template>

<script setup>
defineProps({
  items: { type: Array, required: true }
});
</script>

<style lang="scss" scoped>
.stats {
  display: flex;
  flex-wrap: wrap;
  gap: 20px 28px;

  &__item {
    display: flex;
    flex-direction: column;
    gap: 2px;
  }

  &__value {
    font-size: clamp(1.75rem, 1.3rem + 1.4vw, 2.25rem);
    font-weight: 600;
    line-height: 1.1;
    letter-spacing: -0.02em;
    font-variant-numeric: tabular-nums;
  }

  &__label {
    font-size: var(--fs-small);
    color: var(--color-secondary);
  }
}
</style>
