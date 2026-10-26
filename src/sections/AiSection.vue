<template>
  <section id="ai" class="ai container" aria-labelledby="ai-title">
    <div v-reveal>
      <SectionHead
        id="ai-title"
        kicker="Building with AI"
        title="Agents are my day job."
        subtitle="Here is what I have learned shipping them."
      >
        I use LLMs in two ways: as the product we sell, and as the way we build it.
        Both taught me that the model is the easy part.
      </SectionHead>
    </div>

    <ul class="ai__grid">
      <li
        v-for="(item, index) in ai"
        :key="item.icon"
        v-reveal="index % 2 * 100"
        class="ai__card"
      >
        <span class="ai__card_icon">
          <AiIcon :name="item.icon" class="ai__card_svg" />
        </span>
        <h3 class="ai__card_title">
          {{ item.title }}
        </h3>
        <p class="ai__card_text">
          {{ item.text }}
        </p>
      </li>
    </ul>

    <ul v-reveal class="ai__principles">
      <li v-for="item in principles" :key="item" class="ai__principle">
        {{ item }}
      </li>
    </ul>
  </section>
</template>

<script setup>
import AiIcon from '../components/AiIcon.vue';
import SectionHead from '../components/SectionHead.vue';

import { ai, principles } from '../data/site';
</script>

<style lang="scss" scoped>
.ai {
  padding-bottom: clamp(56px, 10vw, 120px);

  &__grid {
    display: grid;
    gap: 16px;
    margin-top: clamp(32px, 5vw, 56px);

    @include up(md) {
      grid-template-columns: repeat(2, minmax(0, 1fr));
      gap: 20px;
    }
  }

  &__card {
    padding: clamp(24px, 3vw, 36px);

    border: 1px solid var(--color-border);
    border-radius: var(--radius-card);

    transition: background-color 0.25s, border-color 0.25s;

    @include hover {
      border-color: transparent;
      background: var(--color-surface);
    }

    &_icon {
      display: inline-flex;
      align-items: center;
      justify-content: center;
      width: 48px;
      height: 48px;

      border-radius: 14px;
      background: var(--color-surface);
      color: var(--color-primary);
    }

    &_svg {
      width: 24px;
      height: 24px;
    }

    &_title {
      margin-top: 24px;

      font-size: var(--fs-h3);
      font-weight: 600;
      line-height: 1.2;
      letter-spacing: -0.01em;
    }

    &_text {
      margin-top: 10px;
      color: var(--color-secondary);
      text-wrap: pretty;
    }
  }

  &__principles {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
    margin-top: 28px;
  }

  &__principle {
    padding: 10px 18px;

    border-radius: var(--radius-pill);
    background: var(--color-surface);

    font-size: var(--fs-small);
    font-weight: 500;
  }
}
</style>
