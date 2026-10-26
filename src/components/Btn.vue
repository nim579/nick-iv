<template>
  <a
    class="btn"
    :class="`btn_${variant}`"
    :href="href"
    :target="external ? '_blank' : undefined"
    :rel="external ? 'noopener noreferrer' : undefined"
  >
    <slot />
    <IconArrow v-if="external" class="btn__icon" aria-hidden="true" />
  </a>
</template>

<script setup>
import IconArrow from '../../assets/images/icons/arrow-up-right.svg?component';

defineProps({
  href: { type: String, required: true },
  variant: { type: String, default: 'primary' },
  external: { type: Boolean, default: false }
});
</script>

<style lang="scss" scoped>
.btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 6px;
  min-height: 48px;
  padding: 0 24px;

  border: 1px solid transparent;
  border-radius: var(--radius-pill);

  font-size: var(--fs-small);
  font-weight: 600;
  line-height: 1;
  white-space: nowrap;

  transition: background-color 0.2s, border-color 0.2s, color 0.2s, transform 0.2s;

  &_primary {
    background: var(--color-primary);
    color: var(--color-on-primary);

    @include hover {
      transform: translateY(-1px);
      opacity: 0.88;
    }
  }

  &_secondary {
    border-color: var(--color-border);
    background: transparent;
    color: var(--color-primary);

    @include hover {
      background: var(--color-surface);
    }
  }

  &:active {
    transform: scale(0.98);
  }

  &__icon {
    width: 16px;
    height: 16px;
    margin-right: -4px;
  }
}
</style>
