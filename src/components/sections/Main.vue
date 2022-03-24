<template>
  <section class="sectionMain">
    <article class="sectionMain__profile">
      <div class="sectionMain__profile_userpic">
        <img src="../../../assets/images/userpic.png" alt="" class="sectionMain__profile_userpic_image">
      </div>
      <div class="sectionMain__profile_content">
        <h1 class="sectionMain__profile_name">
          Nikolay Ivanushkin
        </h1>
        <p class="sectionMain__profile_subline">
          Fullstack developer & CTO
        </p>

        <ul class="sectionMain__profile_socials">
          <li v-for="item of socials" :key="item.name" class="sectionMain__profile_social">
            <a :href="item.link" target="_blank" :title="item.title" class="sectionMain__profile_social_link">
              <component :is="`icon-${item.name}`" class="sectionMain__profile_social_icon" />
            </a>
          </li>
        </ul>
      </div>
      <div class="sectionMain__profile_spacer" />
    </article>

    <slot :next="nextSection" />
  </section>
</template>

<script>
import IconEmail from '../../../assets/images/icon_email.svg?component';
import IconGithub from '../../../assets/images/icon_github.svg?component';
import IconMust from '../../../assets/images/icon_teletype.svg?component';
import IconTeletype from '../../../assets/images/icon_must.svg?component';

import Scroll from '../Scroll.vue';

export default {
  components: {
    IconEmail, IconGithub, IconMust, IconTeletype,
    Scroll
  },

  props: {
    nextSection: { type: Object, default: null }
  },

  computed: {
    socials() {
      return [
        {name: 'email', link: 'mailto:nick@nick-iv.me', title: 'Email'},
        {name: 'github', link: 'https://github.com/nim579/', title: 'GitHub'},
        {name: 'teletype', link: 'https://blog.nick-iv.me', title: 'Teletype'},
        {name: 'must', link: 'https://mustapp.com/@nick-iv', title: 'Must'}
      ];
    }
  },
};
</script>

<style lang="scss" scoped>
.sectionMain {
  &__profile {
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: center;

    margin: auto;
    padding: sizes.$margin;

    &_userpic {
      display: block;
      flex: 0 0 auto;
      width: 120px;
      height: 120px;
      margin-right: sizes.$margin;
      @include ui.mask-image();

      &_image {
        width: 100%;
        height: auto;
      }
    }
    &_spacer {
      display: block;
      flex: 0 0 auto;
      width: 120px;
      height: 120px;
      margin-left: sizes.$margin;
    }

    &_content {
      display: flex;
      flex-direction: column;
      justify-content: flex-start;
      flex: 1 1 auto;
      align-self: stretch;
      min-height: 100%;
    }

    &_name {
      display: block;
      margin: 0;

      @include fonts.sans(semibold);
      @include sizes.font(34, 40);

      color: colors.get(primary);
      text-align: left;
    }
    &_subline {
      display: block;
      margin: sizes.em(4, 20) 0 0;

      @include fonts.sans();
      @include sizes.font(20, 24);

      color: colors.get(primary);
      text-align: left;
    }

    &_socials {
      display: flex;
      flex-direction: row;
      flex-wrap: wrap;
      align-items: center;
      justify-content: flex-start;
      margin: auto calc(sizes.$gap / -2) calc(sizes.$gap / -2);
      padding: calc(sizes.$gap / 2) 0 0;
      list-style-type: none;
    }
    &_social {
      display: inline-block;
      width: sizes.$ui;
      height: sizes.$ui;
      margin: calc(sizes.$gap / 2);

      background: colors.get(primary);
      @include ui.mask-image();

      &_link {
        text-decoration: none;
      }
      &_icon {
        width: auto;
        height: 100%;
        color: colors.get(on-primary);
        vertical-align: top;
      }
    }

    @include sizes.screen() {
      flex-direction: column;
      align-items: center;

      &_spacer {
        display: none;
      }
      &_content {
        align-items: center;
      }
      &_userpic {
        margin-right: 0;
        margin-bottom: sizes.$ui;
      }
      &_name {
        text-align: center;
      }
      &_subline {
        text-align: center;
      }
      &_socials {
        margin-top: calc(sizes.$ui / 2);
      }
    }
  }
}
</style>
