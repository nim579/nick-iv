<template>
  <section id="products" class="products container" aria-labelledby="products-title">
    <div v-reveal>
      <SectionHead
        id="products-title"
        kicker="Products"
        title="Used by millions."
        subtitle="Two products I built and led from the first commit."
      />
    </div>

    <article id="teletype" v-reveal class="product product_teletype">
      <div class="product__info">
        <LogoTeletype class="product__logo product__logo_teletype" role="img" aria-label="Teletype" />
        <p class="product__text">
          Creators platform. The second most popular blogging platform in Russia.
        </p>

        <Stats :items="products.teletype.stats" class="product__stats" />

        <div class="product__bloggers">
          <p class="product__bloggers_title">
            Home to top Russian bloggers
          </p>
          <ul class="product__bloggers_list">
            <li v-for="blog in products.teletype.bloggers" :key="blog.name">
              <a
                :href="blog.link"
                class="blogger"
                target="_blank"
                rel="noopener noreferrer"
              >
                <Pic :src="blog.userpic" class="blogger__userpic squircle" alt="" :width="28" :height="28" />
                {{ blog.name }}
              </a>
            </li>
          </ul>
        </div>

        <div class="product__actions">
          <Btn :href="products.teletype.link" external>
            Join Teletype
          </Btn>
        </div>
      </div>

      <div class="product__art product__art_teletype">
        <Pic
          :src="products.teletype.art"
          :dark="products.teletype.artDark"
          alt="Teletype blog page in the browser"
          :width="1200"
          :height="788"
        />
      </div>
    </article>

    <article id="must" v-reveal class="product product_must">
      <div class="product__art product__art_must">
        <Pic
          :src="products.must.art"
          :dark="products.must.artDark"
          alt="Must app on iPhone: Today screen with trending movies"
          :width="600"
          :height="1223"
        />
      </div>

      <div class="product__info">
        <div class="product__brand">
          <img :src="logoMust" class="product__logo product__logo_must squircle" alt="" width="40" height="40">
          <h3 class="product__name">
            Must
          </h3>
        </div>
        <p class="product__text">
          Social network for movie lovers. iOS, Android and Web apps.
          Awwwards 2017 and Red Dot Design 2019 winner.
        </p>

        <Stats :items="products.must.stats" class="product__stats" />

        <div class="product__actions">
          <Btn :href="products.must.link" external>
            Join Must
          </Btn>
        </div>
      </div>
    </article>
  </section>
</template>

<script setup>
import Btn from '../components/Btn.vue';
import Pic from '../components/Pic.vue';
import SectionHead from '../components/SectionHead.vue';
import Stats from '../components/Stats.vue';

import LogoTeletype from '../../assets/images/logo_teletype.svg?component';
import logoMust from '../../assets/images/logo_must.svg?url';

import { products } from '../data/site';
</script>

<style lang="scss" scoped>
.products {
  padding-bottom: clamp(56px, 10vw, 120px);
}

.product {
  display: grid;
  gap: 32px;
  margin-top: 20px;
  padding: clamp(24px, 5vw, 64px);
  overflow: hidden;

  border-radius: var(--radius-card);
  background: var(--color-surface);

  &:first-of-type {
    margin-top: clamp(32px, 5vw, 56px);
  }

  @include up(md) {
    align-items: center;
    gap: 56px;

    &_teletype {
      grid-template-columns: minmax(0, 0.9fr) minmax(0, 1.1fr);
    }

    &_must {
      grid-template-columns: minmax(0, 0.7fr) minmax(0, 1.3fr);
    }
  }

  &__brand {
    display: flex;
    align-items: center;
    gap: 14px;
  }

  &__logo {
    &_teletype {
      width: auto;
      height: 28px;
    }

    &_must {
      width: 40px;
      height: 40px;
    }
  }

  &__name {
    font-size: var(--fs-h2);
    font-weight: 600;
    line-height: 1;
    letter-spacing: -0.03em;
  }

  &__text {
    max-width: 46ch;
    margin-top: 20px;

    font-size: var(--fs-lead);
    line-height: 1.45;
    color: var(--color-secondary);
  }

  &__stats {
    margin-top: 28px;
  }

  &__bloggers {
    margin-top: 32px;

    &_title {
      margin-bottom: 12px;
      font-size: var(--fs-small);
      color: var(--color-secondary);
    }

    &_list {
      display: flex;
      flex-wrap: wrap;
      gap: 8px;
    }
  }

  &__actions {
    margin-top: 32px;
  }

  &__art {
    &_teletype {
      margin: 0 calc(clamp(24px, 5vw, 64px) * -1) calc(clamp(24px, 5vw, 64px) * -1) 0;

      :deep(img) {
        width: 100%;
      }

      @include up(md) {
        margin: 0 calc(clamp(24px, 5vw, 64px) * -1) 0 0;

        :deep(img) {
          width: 118%;
          max-width: none;
        }
      }
    }

    &_must {
      display: flex;
      justify-content: center;

      :deep(img) {
        width: min(100%, 300px);
      }

      @include down(md) {
        order: 2;
        margin-bottom: calc(clamp(24px, 5vw, 64px) * -0.5);
      }
    }
  }
}

.blogger {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 4px 14px 4px 4px;

  border-radius: var(--radius-pill);
  background: var(--color-bg);

  font-size: 0.875rem;
  font-weight: 500;

  transition: transform 0.2s;

  @include hover {
    transform: translateY(-1px);
  }

  &__userpic {
    width: 28px;
    height: 28px;
    overflow: hidden;

    :deep(img) {
      width: 100%;
      height: 100%;
    }
  }
}
</style>
