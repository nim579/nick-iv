<template>
  <footer id="contact" class="footer">
    <div class="footer__inner container">
      <div v-reveal class="footer__cta">
        <h2 class="footer__title">
          Let's build something.
        </h2>
        <a :href="`mailto:${site.email}`" class="footer__email">{{ site.email }}</a>
      </div>

      <div class="footer__bottom">
        <p class="footer__copy">
          &copy; {{ year }}, {{ site.name }}
        </p>

        <ul class="footer__links">
          <li v-for="item in socials" :key="item.name">
            <a
              :href="item.link"
              class="footer__link"
              target="_blank"
              rel="me noopener noreferrer"
            >{{ item.label }}</a>
          </li>
        </ul>
      </div>
    </div>
  </footer>
</template>

<script setup>
import { site, socials } from '../data/site';

const year = new Date().getFullYear();
</script>

<style lang="scss" scoped>
.footer {
  border-top: 1px solid var(--color-border);

  &__inner {
    padding-top: clamp(56px, 10vw, 112px);
    padding-bottom: 32px;
  }

  &__title {
    font-size: var(--fs-display);
    font-weight: 600;
    line-height: 1.02;
    letter-spacing: -0.04em;
    text-wrap: balance;
  }

  &__email {
    display: inline-block;
    margin-top: 20px;
    padding-bottom: 2px;

    border-bottom: 2px solid var(--color-border);

    font-size: var(--fs-h2);
    font-weight: 500;
    letter-spacing: -0.02em;
    word-break: break-word;

    transition: border-color 0.2s;

    @include hover {
      border-color: var(--color-primary);
    }
  }

  &__bottom {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    justify-content: space-between;
    gap: 12px 24px;
    margin-top: clamp(48px, 8vw, 96px);

    font-size: var(--fs-small);
    color: var(--color-secondary);
  }

  &__links {
    display: flex;
    flex-wrap: wrap;
    gap: 8px 24px;
  }

  &__link {
    transition: color 0.2s;

    @include hover {
      color: var(--color-primary);
    }
  }
}
</style>
