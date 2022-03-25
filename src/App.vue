<template>
  <div id="app">
    <metainfo />
    <router-view />

    <!-- Yandex.Metrika counter -->
    <Metrika />
    <MetrikaNS />
    <!-- /Yandex.Metrika counter -->
  </div>
</template>

<script>
import ogImage from '../assets/images/sharing.png?url';
import touchImage from '../assets/images/apple-touch-icon.png?url';

import { script as Metrika, noscript as MetrikaNS} from './components/Metrika';

export default {
  components: { Metrika, MetrikaNS },

  data: () => ({
    site: 'https://nick-iv.me',
  }),

  metaInfo() {
    return {
      meta: [
        { property: 'og:url', content: this.site },
        { property: 'twitter:card', content: 'summary_large_image' },
        { property: 'og:title', content: 'Nick Iv' },
        { property: 'twitter:title', content: 'Nick Iv' },
        { property: 'og:description', content: 'Fullstack developer & CTO' },
        { property: 'twitter:description', content: 'Fullstack developer & CTO' },
        { property: 'og:image', content: this.site + ogImage },
        { property: 'twitter:image', content: this.site + ogImage },
        { property: 'og:image:type', content: 'image/png' },
        { property: 'og:image:width', content: '1200' },
        { property: 'og:image:height', content: '630' },
      ],

      link: [
        { rel: 'cannonical', href: this.site + this.$route.path },
        { rel: 'apple-touch-icon', once: true, href: this.site + touchImage },
      ]
    };
  }
};
</script>


<style lang="scss">
@use './styles/global';

html {
  @include fonts.sans();

  background: colors.get(bg);

  font-size: sizes.$font;
  color: colors.get(primary);

  @include global.smooth();
}

html, body {
  width: 100%;

  min-height: 100vh;
  min-height: -webkit-fill-available;
  min-width: sizes.$min;

  margin: 0;
  padding: 0;
  box-sizing: border-box;

  &.m_snap {
    scroll-behavior: smooth;
    scroll-snap-type: y mandatory;
    scroll-padding: 0;
    overflow: auto;
  }
  &.m_fixed {
    position: fixed;
    height: 100vh;
    height: -webkit-fill-available;
    overflow: hidden;
    -webkit-overflow-scrolling: touch;
  }
}

body {
    position: relative;
    -webkit-tap-highlight-color: fade-out(white, 1);
    -webkit-tap-highlight-color: fade-out(white, 1);
    -webkit-focus-ring-color: fade-out(white, 1);
    -webkit-text-size-adjust: none;
    outline: none;
}

img {
    border: 0;
    vertical-align: top;
}

#app {
    display: block;
    width: 100%;
    height: 100%;
    min-height: 100vh;
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}
</style>
