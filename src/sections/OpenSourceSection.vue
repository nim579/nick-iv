<template>
  <section id="open-source" class="oss container" aria-labelledby="oss-title">
    <span id="github" class="oss__anchor" aria-hidden="true" />

    <div v-reveal>
      <SectionHead
        id="oss-title"
        kicker="Open source"
        title="Small tools, made in the open."
        subtitle="Things I needed once and shared."
      />
    </div>

    <ul class="oss__grid">
      <li
        v-for="(item, index) in openSource"
        :key="item.name"
        v-reveal="index % 3 * 80"
      >
        <a
          :href="item.link"
          class="repo"
          target="_blank"
          rel="noopener noreferrer"
        >
          <div class="repo__art">
            <component :is="arts[item.art]" class="repo__svg" aria-hidden="true" />
          </div>
          <h3 class="repo__name">
            {{ item.name }}
            <span v-if="item.badge" class="repo__badge">{{ item.badge }}</span>
          </h3>
          <p class="repo__text">
            {{ item.text }}
          </p>
        </a>
      </li>
    </ul>

    <div class="oss__actions">
      <Btn href="https://github.com/nim579" variant="secondary" external>
        All repositories on GitHub
      </Btn>
    </div>
  </section>
</template>

<script setup>
import Btn from '../components/Btn.vue';
import SectionHead from '../components/SectionHead.vue';

import ArtFractals from '../../assets/images/oss/fractals.svg?component';
import ArtNodeSrv from '../../assets/images/oss/node-srv.svg?component';
import ArtDnsRelay from '../../assets/images/oss/dns_relay.svg?component';
import ArtLinkEnricher from '../../assets/images/oss/link-enricher.svg?component';
import ArtEnvary from '../../assets/images/oss/envary.svg?component';
import ArtDoMigrate from '../../assets/images/oss/do-migrate.svg?component';

import { openSource } from '../data/site';

const arts = {
  'fractals': ArtFractals,
  'node-srv': ArtNodeSrv,
  'dns_relay': ArtDnsRelay,
  'link-enricher': ArtLinkEnricher,
  'envary': ArtEnvary,
  'do-migrate': ArtDoMigrate
};
</script>

<style lang="scss" scoped>
.oss {
  position: relative;
  padding-bottom: clamp(56px, 10vw, 120px);

  // Keeps the old #github links working.
  &__anchor {
    position: absolute;
    top: 0;
  }

  &__grid {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 28px 16px;
    margin-top: clamp(32px, 5vw, 56px);

    @include up(md) {
      grid-template-columns: repeat(3, minmax(0, 1fr));
      gap: 40px 20px;
    }
  }

  &__actions {
    margin-top: clamp(32px, 5vw, 56px);
  }
}

.repo {
  --tile: var(--color-surface);

  display: block;

  &__art {
    aspect-ratio: 1;
    padding: 12%;

    border-radius: var(--radius-card);
    background: var(--tile);
    color: var(--color-primary);

    transition: background-color 0.25s;
  }

  @include hover {
    --tile: var(--color-surface-hover);
  }

  &__svg {
    width: 100%;
    height: 100%;
    overflow: visible;
  }

  &__name {
    margin-top: 16px;

    font-size: var(--fs-h3);
    font-weight: 600;
    line-height: 1.2;
  }

  &__badge {
    display: inline-block;
    margin-left: 6px;
    padding: 2px 8px;
    border-radius: var(--radius-pill);
    background: var(--color-surface);
    font-size: 0.75rem;
    font-weight: 600;
    line-height: 1.4;
    letter-spacing: 0.02em;
    color: var(--color-secondary);
    vertical-align: 0.15em;
  }

  &__text {
    margin-top: 4px;
    font-size: var(--fs-small);
    color: var(--color-secondary);
    text-wrap: pretty;
  }

  // Illustration colours come from the theme.
  &__svg :deep(.ac) {
    stroke: var(--color-accent);
  }

  &__svg :deep(.bg) {
    fill: var(--tile);
  }

  &__svg :deep(.hl) {
    stroke: var(--tile);
  }

  // Hover animations, only for people who did not ask for less motion.
  @include motion-ok {
    &__svg :deep(*) {
      transition: translate 0.45s cubic-bezier(0.2, 0.7, 0.2, 1);
    }

    &:hover &__svg :deep(.tl),
    &:focus-visible &__svg :deep(.tl) { translate: -4px -4px; }
    &:hover &__svg :deep(.tr),
    &:focus-visible &__svg :deep(.tr) { translate: 4px -4px; }
    &:hover &__svg :deep(.bl),
    &:focus-visible &__svg :deep(.bl) { translate: -4px 4px; }
    &:hover &__svg :deep(.br),
    &:focus-visible &__svg :deep(.br) { translate: 4px 4px; }

    &:hover &__svg :deep(.tl2),
    &:focus-visible &__svg :deep(.tl2) { translate: -5px -5px; }
    &:hover &__svg :deep(.tr2),
    &:focus-visible &__svg :deep(.tr2) { translate: 5px -5px; }
    &:hover &__svg :deep(.bl2),
    &:focus-visible &__svg :deep(.bl2) { translate: -5px 5px; }
    &:hover &__svg :deep(.br2),
    &:focus-visible &__svg :deep(.br2) { translate: 5px 5px; }

    &:hover &__svg :deep(.up),
    &:focus-visible &__svg :deep(.up) { translate: 0 -6px; }

    &:hover &__svg :deep(.k1),
    &:focus-visible &__svg :deep(.k1) { translate: 34px 0; }
    &:hover &__svg :deep(.k2),
    &:focus-visible &__svg :deep(.k2) { translate: -40px 0; }
    &:hover &__svg :deep(.k3),
    &:focus-visible &__svg :deep(.k3) { translate: 38px 0; }

    &:hover &__svg :deep(.dash),
    &:focus-visible &__svg :deep(.dash) {
      animation: march 0.8s linear infinite;
    }
  }
}

@keyframes march {
  to {
    stroke-dashoffset: -11;
  }
}
</style>
