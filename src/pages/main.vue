<template>
  <div class="main">
    <Menu :sections="sections" :current="section" :in-view="menuSection" :visible="section !== 'main'" />

    <template v-for="item in sections" :key="item.name">
      <div v-viewport.exact="(inView) => onSectionView(item.name, inView)" class="main__viewmark" />

      <component
        :is="`section-${item.name}`"
        v-scroll="item.name == section"
        v-viewport="(inView, ratio) => onViewportDebounced(item, inView, ratio)"
        class="main__section"
        :data-theme="item.theme"
        :next-section="sections[sectionsIndex[item.name] + 1]"
      />
    </template>

    <footer class="main__footer">
      &copy; {{ new Date().getFullYear() }}, Nick Iv
    </footer>
  </div>
</template>

<script>
import SectionMain from '../components/sections/Main.vue';
import SectionMust from '../components/sections/Must.vue';
import SectionTeletype from '../components/sections/Teletype.vue';
import SectionGithub from '../components/sections/GitHub.vue';

import Menu from '../components/Menu.vue';

import reduce from 'lodash/reduce';
import debounce from 'lodash/debounce';

export default {
  components: {
    SectionMain, SectionMust, SectionTeletype, SectionGithub,
    Menu
  },

  data: () => ({
    menuSection: null
  }),

  computed: {
    sections() {
      return [
        { name: 'main', link: '', label: 'About' },
        { name: 'teletype', link: 'teletype', label: 'Teletype', theme: 'light' },
        { name: 'must', link: 'must', label: 'Must', theme: 'light' },
        { name: 'github', link: 'github', label: 'GitHub Projects' }
      ];
    },

    sectionsIndex() {
      return reduce(this.sections, (mem, item, index) => {
        mem[item.name] = index;
        return mem;
      }, {});
    },

    section() {
      return this.$route.hash.replace(/^#/, '') || 'main';
    },

    onViewportDebounced() { return debounce(this.onViewport, 200); }
  },

  methods: {
    onViewport(section, inView) {
      if (inView)
        this.$router.push({ hash: section.link ? `#${section.link}` : '#' });
    },
    onSectionView(section, inView) {
      if (inView)
        this.menuSection = section;
    }
  },

  metaInfo() {
    return {
      title: 'Nick Iv',
      // htmlAttrs: {
      //   'class': 'm_snap'
      // }
    };
  }
};
</script>

<style lang="scss" scoped>
.main {
  &__section {
    display: flex;
    flex-direction: column;
    align-items: center;
    min-height: 100vh;
    max-height: 100%;

    background: colors.get(bg);
    color: colors.get(primary);

    // &.m_snap {
    //   scroll-snap-align: end;
    // }
  }

  &__viewmark {
    position: relative;
    top: 100vh;
    height: 0;

    pointer-events: none;
    opacity: 0;

    transform: translateY(sizes.$ui * -1);
  }

  &__footer {
    display: flex;
    align-items: center;
    justify-content: center;
    padding: sizes.$margin;

    @include fonts.sans(medium);
    @include sizes.font(12);

    color: colors.get(secondary);
    text-align: center;
  }
}
</style>
