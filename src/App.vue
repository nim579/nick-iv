<template>
  <router-view />
</template>

<script setup>
import { computed } from 'vue';
import { useRoute } from 'vue-router';
import { useHead } from '@unhead/vue';

import ogImage from '../assets/images/sharing.png?url';
import touchImage from '../assets/images/apple-touch-icon.png?url';
import fontRegular from '../assets/fonts/SFRounded-Regular.woff2?url';
import fontSemibold from '../assets/fonts/SFRounded-Semibold.woff2?url';

import { site, socials } from './data/site';

const route = useRoute();

const canonical = computed(() => site.url + (route.path === '/' ? '/' : route.path));
const image = site.url + ogImage;

const person = {
  '@context': 'https://schema.org',
  '@type': 'Person',
  name: site.fullName,
  alternateName: site.name,
  jobTitle: 'CTO',
  url: site.url,
  email: site.email,
  image: image,
  sameAs: socials.map(item => item.link)
};

// Yandex.Metrika, without Webvisor (session recording).
const metrika = `
  (function (m, e, t, r, i, k, a) {
    m[i] = m[i] || function () { (m[i].a = m[i].a || []).push(arguments); };
    m[i].l = 1 * new Date();
    k = e.createElement(t); a = e.getElementsByTagName(t)[0]; k.async = 1; k.src = r; a.parentNode.insertBefore(k, a);
  })(window, document, 'script', 'https://mc.yandex.ru/metrika/tag.js', 'ym');

  ym(22330363, 'init', { clickmap: true, trackLinks: true, accurateTrackBounce: true });
`;

useHead({
  htmlAttrs: { lang: 'en' },
  title: site.title,
  titleTemplate: null,

  meta: [
    { name: 'description', content: site.description },
    { name: 'author', content: site.fullName },
    { property: 'og:type', content: 'website' },
    { property: 'og:site_name', content: site.name },
    { property: 'og:locale', content: 'en_US' },
    { property: 'og:url', content: canonical },
    { property: 'og:title', content: site.title },
    { property: 'og:description', content: site.description },
    { property: 'og:image', content: image },
    { property: 'og:image:type', content: 'image/png' },
    { property: 'og:image:width', content: '1200' },
    { property: 'og:image:height', content: '630' },
    { name: 'twitter:card', content: 'summary_large_image' },
    { name: 'twitter:title', content: site.title },
    { name: 'twitter:description', content: site.description },
    { name: 'twitter:image', content: image }
  ],

  link: [
    { rel: 'canonical', href: canonical },
    { rel: 'apple-touch-icon', href: site.url + touchImage },
    { rel: 'preload', href: fontRegular, as: 'font', type: 'font/woff2', crossorigin: 'anonymous' },
    { rel: 'preload', href: fontSemibold, as: 'font', type: 'font/woff2', crossorigin: 'anonymous' }
  ],

  script: [
    { type: 'application/ld+json', innerHTML: JSON.stringify(person) },
    { innerHTML: metrika }
  ]
});
</script>
