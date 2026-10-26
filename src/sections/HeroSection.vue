<template>
  <section id="top" class="hero container">
    <div class="hero__who">
      <Pic
        :src="userpic" class="hero__userpic squircle" alt="Nikolay Ivanushkin"
        :width="72" :height="72"
        eager
      />
      <p class="hero__name">
        <span class="hero__name_full">{{ site.fullName }}</span>
        <span class="hero__name_role">{{ site.role }}</span>
      </p>
    </div>

    <h1 class="hero__title">
      I build AI agents
      <span class="hero__title_muted">and products used by millions of people.</span>
    </h1>

    <div class="hero__actions">
      <Btn :href="`mailto:${site.email}`">
        Email me
      </Btn>
      <Btn href="#now" variant="secondary">
        What I do now
      </Btn>

      <ul class="hero__socials">
        <li v-for="item in socials" :key="item.name">
          <a
            :href="item.link"
            class="hero__social squircle"
            :aria-label="item.label"
            :title="item.label"
            target="_blank"
            rel="me noopener noreferrer"
          >
            <component :is="icons[item.name]" class="hero__social_icon" aria-hidden="true" />
          </a>
        </li>
      </ul>
    </div>

    <div class="hero__worked">
      <p class="hero__worked_label">
        Built and led
      </p>
      <ul class="hero__worked_list">
        <li class="hero__worked_item">
          <LogoCaptain class="hero__worked_logo hero__worked_logo_captain" aria-hidden="true" />
          Captain
        </li>
        <li class="hero__worked_item">
          <LogoTeletype class="hero__worked_logo hero__worked_logo_teletype" aria-hidden="true" />
          <span class="visually-hidden">Teletype</span>
        </li>
        <li class="hero__worked_item">
          <img :src="logoMust" class="hero__worked_logo hero__worked_logo_must" alt="" width="24" height="24">
          Must
        </li>
      </ul>
    </div>
  </section>
</template>

<script setup>
import Btn from '../components/Btn.vue';
import Pic from '../components/Pic.vue';

import IconGithub from '../../assets/images/icon_github.svg?component';
import IconTeletype from '../../assets/images/icon_teletype.svg?component';
import IconMust from '../../assets/images/icon_must.svg?component';
import LogoCaptain from '../../assets/images/logo_captain.svg?component';
import LogoTeletype from '../../assets/images/logo_teletype.svg?component';
import logoMust from '../../assets/images/logo_must.svg?url';

import { image } from '../data/images';
import { site, socials } from '../data/site';

const userpic = image('userpic');

const icons = {
  github: IconGithub,
  teletype: IconTeletype,
  must: IconMust
};
</script>

<style lang="scss" scoped>
.hero {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  justify-content: center;

  // The first screen fills most of the viewport; the next card peeks out below.
  min-height: 85vh;
  min-height: 85svh;
  padding-top: clamp(24px, 5svh, 64px);
  padding-bottom: clamp(24px, 5svh, 64px);

  &__who {
    display: flex;
    align-items: center;
    gap: 16px;
  }

  &__userpic {
    flex: 0 0 auto;
    width: 72px;
    height: 72px;
    overflow: hidden;
    background: var(--color-surface);

    :deep(img) {
      width: 100%;
      height: 100%;
    }
  }

  &__name {
    display: flex;
    flex-direction: column;

    &_full {
      font-size: var(--fs-h3);
      font-weight: 600;
      line-height: 1.2;
    }

    &_role {
      color: var(--color-secondary);
    }
  }

  &__title {
    max-width: 14ch;
    margin-top: clamp(24px, 5svh, 56px);

    // Limited by the width and by the height of the screen, so that the whole
    // first screen still fits when the window is short.
    font-size: clamp(2.25rem, min(1.6rem + 5.5vw, 10vh), 5.5rem);
    font-size: clamp(2.25rem, min(1.6rem + 5.5vw, 10svh), 5.5rem);
    font-weight: 600;
    line-height: 1.02;
    letter-spacing: -0.04em;
    text-wrap: balance;

    &_muted {
      color: var(--color-secondary);
    }

    @include up(md) {
      max-width: 17ch;
    }
  }

  &__actions {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    gap: 12px;
    margin-top: clamp(24px, 4svh, 44px);
  }

  &__socials {
    display: flex;
    gap: 10px;
    margin-left: 8px;
  }

  &__social {
    display: block;
    width: 44px;
    height: 44px;

    background: var(--color-surface);
    color: var(--color-primary);

    transition: background-color 0.2s, color 0.2s;

    @include hover {
      background: var(--color-primary);
      color: var(--color-on-primary);
    }

    &_icon {
      width: 100%;
      height: 100%;
    }
  }

  &__worked {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    gap: 12px 32px;
    margin-top: clamp(32px, 8svh, 88px);

    &_label {
      font-size: var(--fs-small);
      color: var(--color-secondary);
    }

    &_list {
      display: flex;
      flex-wrap: wrap;
      align-items: center;
      gap: 12px 32px;
    }

    &_item {
      display: inline-flex;
      align-items: center;
      gap: 8px;

      font-size: 1.125rem;
      font-weight: 600;
    }

    &_logo {
      height: 22px;

      &_captain {
        width: 22px;
      }

      // The wordmark has descenders (y, p): its box is taller than the letters,
      // so it is shifted down to put the letters on the text baseline.
      &_teletype {
        width: auto;
        height: 20px;
        transform: translateY(2px);
      }

      &_must {
        width: 24px;
        height: 24px;
      }
    }
  }
}
</style>
