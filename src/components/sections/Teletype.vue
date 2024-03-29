<template>
  <section class="sectionTeletype">
    <div class="sectionTeletype__content">
      <header class="sectionTeletype__header">
        <LogoTeletype class="sectionTeletype__header_logo" />

        <p class="sectionTeletype__header_text">
          Creators platform. 2th popular platform in Russia
        </p>
      </header>

      <div class="sectionTeletype__info">
        <div class="sectionTeletype__art">
          <img v-if="darkmode" src="../../../assets/images/teletype_art_dark.png" alt="" class="sectionTeletype__art_img">
          <img v-else src="../../../assets/images/teletype_art_light.png" alt="" class="sectionTeletype__art_img">

          <div class="sectionTeletype__art_fade" />
        </div>

        <div class="sectionTeletype__wrap">
          <div class="sectionTeletype__numbers">
            <Numbers :data="numbers" center />
          </div>

          <h3 class="sectionTeletype__subtitle">
            Top Russian bloggers
          </h3>

          <div class="sectionTeletype__bloggers">
            <a
              v-for="blog in bloggers" :key="blog.name"
              class="sectionTeletype__blogger" :class="{'m_nomobile': blog.noMobile}"
              :href="blog.link"
            >
              <div class="sectionTeletype__blogger_userpic">
                <img v-if="blog.userpic" :src="blog.userpic" class="sectionTeletype__blogger_userpic_img">
              </div>
              <div class="sectionTeletype__blogger_name">
                {{ blog.label }}
              </div>
            </a>
          </div>

          <div class="sectionTeletype__actions">
            <a href="https://teletype.in" target="_blank" class="sectionTeletype__button">Join Teletype</a>
          </div>
        </div>
      </div>
    </div>

    <slot :next="nextSection" />
  </section>
</template>

<script>
import Numbers from '../Numbers.vue';
import LogoTeletype from '../../../assets/images/logo_teletype.svg?component';

import userpicLebedev from '../../../assets/images/userpic_lebedev.png?url';
import userpicVarlamov from '../../../assets/images/userpic_varlamov.png?url';
import userpicMiumau from '../../../assets/images/userpic_miumau.png?url';
import userpicGershman from '../../../assets/images/userpic_gershman.png?url';
import userpicStillavin from '../../../assets/images/userpic_stillavin.png?url';

export default {
  components: { Numbers, LogoTeletype },

  props: {
    nextSection: { type: Object, default: null }
  },

  data: () => ({
    numbers: [
      { label: 'MAU', value: '4M' },
      { label: 'Users', value: '750K' },
      { label: 'Articles', value: '2.5M' },
      { label: 'Avg. RPS', value: '480' },
    ],

    bloggers: [
      { name: 'lebedev',   label: 'Artemy Lebedev', link: 'https://blog.tema.ru', userpic: userpicLebedev },
      { name: 'varlamov',  label: 'Ilya Varlamov', link: 'https://varlamov.ru', userpic: userpicVarlamov },
      { name: 'muimau',    label: 'Miu Mau', link: 'https://blog.mammamiu.com', userpic: userpicMiumau },
      { name: 'urbanblog', label: 'Arkadiy Gershman', link: 'https://urbanblog.ru', userpic: userpicGershman, noMobile: true },
      { name: 'stillavin', label: 'Sergey Stillavin', link: 'https://teletype.in/@stillavin', userpic: userpicStillavin, noMobile: true },
      { name: 'more',      label: 'Many more...', link: 'https://teletype.in' },
    ]
  }),

  computed: {
    darkmode() { return this.$dom.colorScheme.darkmode; },
  }
};
</script>

<style lang="scss" scoped>
.sectionTeletype {
  &__content {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: flex-start;
    margin: auto;
    padding: 80px sizes.$margin 60px;

    @include sizes.screen() {
      padding-bottom: sizes.$margin;
    }
  }

  &__header {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: flex-start;

    &_logo {
      display: inline-block;
      margin-bottom: sizes.$gap;
    }
    &_text {
      display: block;
      margin: 0;

      @include fonts.sans();
      @include sizes.font(20);

      color: colors.get(secondary);
      text-align: center;
    }
  }

  &__info {
    display: block;
  }

  &__art {
    position: relative;
    display: block;
    max-width: 800px;
    height: 250px;
    overflow: hidden;

    &_img {
      width: 100%;
      height: auto;
    }
    &_fade {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: linear-gradient(to bottom, colors.get(bg-transparent) 10%, colors.get(bg) 90%);
    }
  }

  &__wrap {
    position: relative;
    margin-top: -60px;

    @include sizes.screen(mobile) {
      margin-top: -15vh;
    }
  }

  &__numbers {
    display: block;
    margin-bottom: 34px;
    overflow: hidden;
  }

  &__subtitle {
    display: block;
    margin: 0 0 sizes.$margin;

    @include fonts.sans(semibold);
    @include sizes.font(20);

    color: colors.get(primary);
    text-align: center;
  }
  &__bloggers {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    grid-gap: sizes.$margin;
    margin-bottom: 34px;

    @include sizes.screen(mobile) {
      grid-template-columns: repeat(2, 1fr);
    }
  }
  &__blogger {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: flex-start;
    text-decoration: none;

    &_userpic {
      display: inline-block;
      width: 75px;
      height: 75px;

      background-color: colors.get(border);
      @include ui.mask-image();

      &_img {
        width: 100%;
        height: auto;
      }
    }
    &_name {
      display: inline-block;
      margin-top: sizes.$gap;

      @include fonts.sans();
      @include sizes.font(18);

      color: colors.get(primary);
      text-align: center;
    }

    @include sizes.screen(mobile) {
      &.m_nomobile {
        display: none;
      }
    }
  }

  &__actions {
    display: block;
    text-align: center;
  }
  &__button {
    display: inline-block;
    margin: 0;
    padding: 15px 30px;

    border-radius: 16px;
    border: 0;
    background: #5B41F5;

    @include fonts.sans(semibold);
    @include sizes.font(15, 24);

    color: #FFFFFF;
    text-align: center;
    text-decoration: none;
  }
}
</style>
