<template>
  <section id="now" class="now container" aria-labelledby="now-title">
    <div v-reveal class="now__card">
      <div class="now__info">
        <p class="now__kicker">
          <LogoCaptain class="now__kicker_logo" aria-hidden="true" />
          Now
        </p>

        <h2 id="now-title" class="now__title">
          Captain.
          <span class="now__title_muted">AI agents for car dealerships.</span>
        </h2>

        <p class="now__text">
          I lead engineering at Captain. It answers customers in WhatsApp, chat and on the phone,
          in their language, and books the test drive into the dealership's calendar before
          a person has to step in.
        </p>

        <Stats :items="captain.stats" class="now__stats" />

        <div class="now__actions">
          <Btn :href="captain.link" external>
            getcaptain.ai
          </Btn>
        </div>

        <p class="now__trusted">
          Trusted by
          <span v-for="(name, index) in captain.trusted" :key="name">
            <strong>{{ name }}</strong>{{ index < captain.trusted.length - 2 ? ', ' : index === captain.trusted.length - 2 ? ' and ' : '' }}
          </span>
          dealers.
        </p>
      </div>

      <figure class="now__demo" aria-label="Sample conversation with Captain">
        <div class="chat">
          <div class="chat__head">
            <LogoCaptain class="chat__head_logo" aria-hidden="true" />
            <div>
              <p class="chat__head_name">
                Captain Sales
              </p>
              <p class="chat__head_meta">
                WhatsApp · replies in 5 s
              </p>
            </div>
          </div>

          <div class="chat__body">
            <p class="chat__msg chat__msg_in">
              Hi! Do you have a GLC 300 in white?
            </p>
            <p class="chat__msg chat__msg_out">
              Yes, 2 in Polar White are in stock. Want to try one this week?
            </p>
            <p class="chat__msg chat__msg_in">
              Thursday after 10?
            </p>
            <p class="chat__msg chat__msg_out">
              Done. Thursday 10:30, Airport Road. I will remind you tomorrow.
            </p>

            <div class="chat__card">
              <p class="chat__card_title">
                Test drive · GLC 300
              </p>
              <p class="chat__card_meta">
                Thu 10:30 · 45 min
              </p>
            </div>
          </div>
        </div>
        <figcaption class="visually-hidden">
          A sample conversation: a customer books a test drive in a few messages.
        </figcaption>
      </figure>
    </div>
  </section>
</template>

<script setup>
import Btn from '../components/Btn.vue';
import Stats from '../components/Stats.vue';

import LogoCaptain from '../../assets/images/logo_captain.svg?component';

import { captain } from '../data/site';
</script>

<style lang="scss" scoped>
.now {
  padding-top: 24px;
  padding-bottom: clamp(56px, 10vw, 120px);

  &__card {
    display: grid;
    gap: 40px;
    padding: clamp(24px, 5vw, 64px);

    border-radius: var(--radius-card);
    background: var(--color-surface);

    @include up(md) {
      grid-template-columns: minmax(0, 1.1fr) minmax(0, 0.9fr);
      align-items: center;
      gap: 56px;
    }
  }

  &__kicker {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    margin-bottom: 20px;

    font-size: var(--fs-small);
    font-weight: 600;
    letter-spacing: 0.08em;
    text-transform: uppercase;
    color: var(--color-secondary);

    &_logo {
      width: 20px;
      height: 20px;
      color: var(--color-primary);
    }
  }

  &__title {
    font-size: var(--fs-h2);
    font-weight: 600;
    line-height: 1.06;
    letter-spacing: -0.03em;

    &_muted {
      color: var(--color-secondary);
    }
  }

  &__text {
    max-width: 52ch;
    margin-top: 20px;

    font-size: var(--fs-lead);
    line-height: 1.45;
    color: var(--color-secondary);
  }

  &__stats {
    margin-top: 32px;
  }

  &__actions {
    margin-top: 32px;
  }

  &__trusted {
    margin-top: 24px;
    font-size: var(--fs-small);
    color: var(--color-secondary);

    strong {
      font-weight: 600;
      color: var(--color-primary);
    }
  }

  &__demo {
    margin: 0;
  }
}

.chat {
  max-width: 440px;
  margin: 0 auto;
  overflow: hidden;

  border: 1px solid var(--color-border);
  border-radius: 24px;
  background: var(--color-bg);
  box-shadow: var(--shadow-card);

  &__head {
    display: flex;
    align-items: center;
    gap: 12px;
    padding: 14px 18px;
    border-bottom: 1px solid var(--color-border);

    &_logo {
      width: 36px;
      height: 36px;
      padding: 6px;
      border-radius: 50%;
      background: var(--color-surface);
    }

    &_name {
      font-weight: 600;
      line-height: 1.2;
    }

    &_meta {
      font-size: 0.8125rem;
      color: var(--color-secondary);
    }
  }

  &__body {
    display: flex;
    flex-direction: column;
    gap: 8px;
    padding: 18px;
  }

  &__msg {
    max-width: 82%;
    padding: 10px 14px;

    border-radius: 18px;
    font-size: var(--fs-small);
    line-height: 1.4;

    &_in {
      align-self: flex-start;
      border-bottom-left-radius: 6px;
      background: var(--color-surface);
    }

    &_out {
      align-self: flex-end;
      border-bottom-right-radius: 6px;
      background: var(--color-primary);
      color: var(--color-on-primary);
    }
  }

  &__card {
    align-self: flex-end;
    margin-top: 6px;
    padding: 12px 14px;

    border: 1px solid var(--color-border);
    border-left: 3px solid var(--color-accent);
    border-radius: 12px;

    &_title {
      font-size: var(--fs-small);
      font-weight: 600;
    }

    &_meta {
      font-size: 0.8125rem;
      color: var(--color-secondary);
    }
  }
}
</style>
