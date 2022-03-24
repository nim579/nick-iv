<template>
  <section class="sectionMust">
    <div class="sectionMust__content">
      <div class="sectionMust__art">
        <img v-if="darkmode" src="../../../assets/images/must_art_dark.png" alt="" class="sectionMust__art_img">
        <img v-else src="../../../assets/images/must_art_light.png" alt="" class="sectionMust__art_img">
        <div class="sectionMust__art_shadow" />
      </div>

      <div class="sectionMust__info">
        <header class="sectionMust__logo">
          <img src="../../../assets/images/logo_must.svg" alt="" class="sectionMust__logo_img">
          <h2 class="sectionMust__logo_name">
            Must
          </h2>
        </header>

        <p class="sectionMust__text">
          Social network for movie lovers. iOS, Android, Web apps.<br>Awwwards 2017, Red Dot Design winner 2019.
        </p>

        <div class="sectionMust__numbers">
          <numbers :data="numbers" />
        </div>

        <a href="https://mustapp.com" target="_blank" class="sectionMust__button">Join Must</a>
      </div>
    </div>

    <slot :next="nextSection" />
  </section>
</template>

<script>
import Numbers from '../Numbers.vue';

export default {
  components: { Numbers },

  props: {
    nextSection: { type: Object, default: null }
  },

  data: () => ({
    numbers: [
      { label: 'MAU', value: '60K' },
      { label: 'Users', value: '550K' },
      { label: 'Movies watched', value: '26M' },
      { label: 'Episodes watched', value: '150M' },
    ]
  }),

  computed: {
    darkmode() { return this.$dom.colorScheme.darkmode; },
  }
};
</script>

<style lang="scss" scoped>
.sectionMust {
  &__content {
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: center;
    width: 100%;
    max-width: 1000px;
    margin: auto;
    padding: 60px sizes.$margin;
    box-sizing: border-box;

    @include sizes.screen() {
      flex-direction: column;
      padding-top: sizes.$margin;
      padding-bottom: 0;
    }
  }

  &__art {
    position: relative;
    display: flex;
    flex-direction: column;
    flex: 1 1 35%;
    max-width: 300px;
    margin-right: 60px;

    &_img {
      position: relative;
      display: block;
      width: 100%;
      height: auto;
      vertical-align: top;

      @include sizes.screen() {
        width: auto;
        height: 100%;
      }
    }
    &_shadow {
      position: absolute;
      top: 10px;
      bottom: 10px;
      left: 10px;
      right: 10px;

      border-radius: 40px;
      box-shadow: 0 25px 60px fade-out(black, 0.85);

      @include sizes.screen() {
        display: none;
      }
    }

    @include sizes.screen(tablet) {
      margin-right: sizes.$margin;
    }
    @include sizes.screen() {
      align-items: center;
      max-height: 35vh;
      margin-right: 0;
      margin-bottom: 40px;
    }
  }

  &__info {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    flex: 1 1 65%;

    @include sizes.screen() {
      align-items: center;
    }
  }

  &__logo {
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: flex-start;
    margin-bottom: sizes.$margin;

    &_img {
      display: inline-block;
      margin-right: sizes.$gap;

      @include sizes.screen() {
        width: sizes.$ui;
      }
    }
    &_name {
      display: inline-block;
      margin: 0;

      @include fonts.sans(semibold);
      @include sizes.font(28);

      color: colors.get(primary);
      text-align: left;

      @include sizes.screen() {
        @include sizes.font(25);
      }
    }
  }

  &__text {
    display: block;
    margin: 0 0 sizes.$margin;

    @include fonts.sans();
    @include sizes.font(20);

    color: colors.get(secondary);
    text-align: left;

    @include sizes.screen() {
      @include sizes.font(18);
      text-align: center;
    }
  }

  &__numbers {
    display: block;
    margin: 0 0 sizes.$margin;
  }

  &__button {
    display: inline-block;
    margin: 0;
    padding: 10px 30px;

    border-radius: 30px;
    border: 0;
    background: #007AFF;

    @include fonts.sans(semibold);
    @include sizes.font(14, 24);

    color: #FFFFFF;
    text-align: center;
    text-decoration: none;
  }
}
</style>
