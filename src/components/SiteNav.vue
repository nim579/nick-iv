<template>
  <header class="nav" :class="{ 'nav_open': open, 'nav_shown': shown }" :aria-hidden="shown ? undefined : 'true'">
    <div class="nav__bar container">
      <a href="#top" class="nav__brand" aria-label="Nick Iv, to the top" @click="open = false">
        <Pic
          :src="userpic" class="nav__userpic squircle" alt=""
          :width="32" :height="32"
          eager
        />
        <span class="nav__name">Nick Iv</span>
      </a>

      <nav id="nav-menu" class="nav__menu" :class="{ 'nav__menu_open': open }" aria-label="Sections">
        <ul class="nav__list">
          <li v-for="item in menu" :key="item.id">
            <a
              :href="`#${item.id}`"
              class="nav__link"
              :class="{ 'nav__link_active': current === item.id }"
              :aria-current="current === item.id ? 'true' : undefined"
              @click="open = false"
            >{{ item.label }}</a>
          </li>
        </ul>
      </nav>

      <div class="nav__actions">
        <Btn :href="`mailto:${site.email}`" class="nav__cta">
          Email me
        </Btn>

        <button
          type="button"
          class="nav__toggle"
          :aria-expanded="open ? 'true' : 'false'"
          aria-controls="nav-menu"
          aria-label="Menu"
          @click="open = !open"
        >
          <span class="nav__toggle_line" />
          <span class="nav__toggle_line" />
        </button>
      </div>
    </div>
  </header>
</template>

<script setup>
import { onBeforeUnmount, onMounted, ref } from 'vue';

import Btn from './Btn.vue';
import Pic from './Pic.vue';

import { image } from '../data/images';
import { menu, site } from '../data/site';

const userpic = image('userpic');

const open = ref(false);
// The bar stays hidden while the hero is on screen: the page is a business card first.
const shown = ref(false);
const current = ref(null);

let observer = null;
const visible = new Set();

const setHash = (id) => {
  const hash = id ? `#${id}` : '';
  if (window.location.hash === hash) return;

  // replaceState: scrolling must not fill the history with sections.
  window.history.replaceState(window.history.state, '', window.location.pathname + window.location.search + hash);
};

const onIntersect = (entries) => {
  entries.forEach((entry) => {
    if (entry.isIntersecting) visible.add(entry.target.id);
    else visible.delete(entry.target.id);
  });

  const next = menu.find(item => visible.has(item.id));
  current.value = next ? next.id : null;
  setHash(current.value);
};

const onScroll = () => {
  const hero = document.getElementById('top');
  const bottom = hero ? hero.getBoundingClientRect().bottom : 0;
  shown.value = bottom < 120;
  if (!shown.value) open.value = false;
};
const onKey = (ev) => { if (ev.key === 'Escape') open.value = false; };

onMounted(() => {
  onScroll();
  window.addEventListener('scroll', onScroll, { passive: true });
  window.addEventListener('keydown', onKey);

  if (!window.IntersectionObserver) return;

  // A thin band in the middle of the screen decides which section is current.
  observer = new IntersectionObserver(onIntersect, { rootMargin: '-45% 0px -50% 0px' });
  menu.forEach((item) => {
    const el = document.getElementById(item.id);
    if (el) observer.observe(el);
  });
});

onBeforeUnmount(() => {
  window.removeEventListener('scroll', onScroll);
  window.removeEventListener('keydown', onKey);
  if (observer) observer.disconnect();
});
</script>

<style lang="scss" scoped>
.nav {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: 10;

  border-bottom: 1px solid var(--color-border);
  background: var(--color-header);
  backdrop-filter: saturate(180%) blur(16px);
  -webkit-backdrop-filter: saturate(180%) blur(16px);

  visibility: hidden;
  transform: translateY(-100%);
  transition: transform 0.3s, visibility 0.3s;

  &_shown {
    visibility: visible;
    transform: none;
  }

  &_open {
    background: var(--color-bg);
  }

  &__bar {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 16px;
    height: var(--header-height);
  }

  &__brand {
    display: inline-flex;
    align-items: center;
    gap: 10px;
    font-weight: 600;
  }

  &__userpic {
    width: 32px;
    height: 32px;
    overflow: hidden;

    :deep(img) {
      width: 100%;
      height: 100%;
    }
  }

  &__list {
    display: flex;
    gap: 4px;
  }

  &__link {
    display: block;
    padding: 8px 14px;

    border-radius: var(--radius-pill);

    font-size: var(--fs-small);
    font-weight: 500;
    color: var(--color-secondary);

    transition: color 0.2s, background-color 0.2s;

    @include hover {
      color: var(--color-primary);
    }

    &_active {
      background: var(--color-surface);
      color: var(--color-primary);
    }
  }

  &__actions {
    display: flex;
    align-items: center;
    gap: 8px;
  }

  // Doubled selector: has to win over the scoped styles of Btn.
  & &__cta {
    min-height: 40px;
    padding: 0 18px;
  }

  &__toggle {
    display: none;
    position: relative;
    width: 40px;
    height: 40px;
    padding: 0;

    border: 0;
    border-radius: 50%;
    background: transparent;
    color: var(--color-primary);
    cursor: pointer;

    &_line {
      position: absolute;
      left: 11px;
      width: 18px;
      height: 2px;
      border-radius: 2px;
      background: currentColor;
      transition: transform 0.25s, top 0.25s;

      &:nth-child(1) { top: 15px; }
      &:nth-child(2) { top: 23px; }
    }
  }

  &_open &__toggle_line {
    &:nth-child(1) { top: 19px; transform: rotate(45deg); }
    &:nth-child(2) { top: 19px; transform: rotate(-45deg); }
  }

  // The menu sits in the centre of the bar on desktop.
  @include up(md) {
    &__menu {
      position: absolute;
      left: 50%;
      transform: translateX(-50%);
    }
  }

  @include down(md) {
    &__toggle {
      display: block;
    }

    & &__cta {
      display: none;
    }

    &__menu {
      position: absolute;
      top: var(--header-height);
      left: 0;
      right: 0;

      padding: 8px var(--gutter) 24px;
      border-bottom: 1px solid var(--color-border);
      background: var(--color-bg);

      visibility: hidden;
      opacity: 0;
      transform: translateY(-8px);
      transition: opacity 0.2s, transform 0.2s, visibility 0.2s;

      &_open {
        visibility: visible;
        opacity: 1;
        transform: none;
      }
    }

    &__list {
      flex-direction: column;
      gap: 0;
    }

    &__link {
      padding: 14px 4px;
      border-radius: 0;
      font-size: 1.25rem;
      font-weight: 600;
      color: var(--color-primary);

      &_active {
        background: transparent;
        color: var(--color-accent);
      }
    }
  }
}
</style>
