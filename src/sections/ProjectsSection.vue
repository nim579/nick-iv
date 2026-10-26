<template>
  <section id="projects" class="projects container" aria-labelledby="projects-title">
    <div v-reveal>
      <SectionHead
        id="projects-title"
        kicker="Projects"
        title="Built for other teams."
        subtitle="Sites and products from the studio side of things."
      >
        Live previews are hosted on dev.nim579.ru.
      </SectionHead>
    </div>

    <ul class="projects__grid">
      <li
        v-for="(project, index) in projects"
        :key="project.name"
        v-reveal="index % 3 * 80"
        class="projects__item"
      >
        <a
          :href="project.link"
          class="project"
          target="_blank"
          rel="noopener noreferrer"
        >
          <div class="project__art">
            <Pic
              :src="project.art"
              :alt="`${project.name} website preview`"
              :width="1200"
              :height="750"
            />
          </div>

          <div class="project__info">
            <h3 class="project__name">
              {{ project.name }}
              <IconArrow class="project__arrow" aria-hidden="true" />
            </h3>
            <p class="project__text">
              {{ project.text }}
            </p>
          </div>
        </a>
      </li>

      <li v-reveal class="projects__item">
        <div class="project project_cta">
          <h3 class="project__cta_title">
            Got a product in mind?
          </h3>
          <p class="project__cta_text">
            A web product, an AI agent or a team that needs a CTO's eye? Write me a line.
          </p>
          <Btn :href="`mailto:${site.email}`">
            Let's talk
          </Btn>
        </div>
      </li>
    </ul>
  </section>
</template>

<script setup>
import Btn from '../components/Btn.vue';
import Pic from '../components/Pic.vue';
import SectionHead from '../components/SectionHead.vue';

import IconArrow from '../../assets/images/icons/arrow-up-right.svg?component';

import { projects, site } from '../data/site';
</script>

<style lang="scss" scoped>
.projects {
  padding-bottom: clamp(56px, 10vw, 120px);

  &__grid {
    display: grid;
    gap: 20px;
    margin-top: clamp(32px, 5vw, 56px);

    @include up(sm) {
      grid-template-columns: repeat(2, minmax(0, 1fr));
    }

    @include up(lg) {
      grid-template-columns: repeat(3, minmax(0, 1fr));
    }
  }

  &__item {
    display: flex;
  }
}

.project {
  display: flex;
  flex-direction: column;
  width: 100%;
  overflow: hidden;

  border: 1px solid var(--color-border);
  border-radius: var(--radius-card);
  background: var(--color-bg);

  transition: transform 0.3s, box-shadow 0.3s;

  @include hover {
    transform: translateY(-4px);
    box-shadow: var(--shadow-card);
  }

  &__art {
    overflow: hidden;
    background: var(--color-surface);
    aspect-ratio: 16 / 10;

    :deep(img) {
      width: 100%;
      height: 100%;
      object-fit: cover;
      object-position: top;
      transition: transform 0.6s cubic-bezier(0.2, 0.7, 0.2, 1);
    }
  }

  @include hover {
    .project__art :deep(img) {
      transform: scale(1.03);
    }
  }

  &__info {
    padding: 24px 28px 28px;
  }

  &__name {
    display: flex;
    align-items: center;
    gap: 6px;

    font-size: var(--fs-h3);
    font-weight: 600;
    line-height: 1.2;
  }

  &__arrow {
    width: 18px;
    height: 18px;
    color: var(--color-secondary);
    transition: transform 0.2s, color 0.2s;
  }

  &:hover &__arrow,
  &:focus-visible &__arrow {
    transform: translate(2px, -2px);
    color: var(--color-primary);
  }

  &__text {
    margin-top: 8px;
    color: var(--color-secondary);
    text-wrap: pretty;
  }

  &_cta {
    align-items: flex-start;
    justify-content: center;
    gap: 12px;
    padding: 28px;

    border-color: transparent;
    background: var(--color-surface);

    @include hover {
      transform: none;
      box-shadow: none;
    }
  }

  &__cta_title {
    font-size: var(--fs-h3);
    font-weight: 600;
    line-height: 1.2;
  }

  &__cta_text {
    margin-bottom: 8px;
    color: var(--color-secondary);
  }
}
</style>
