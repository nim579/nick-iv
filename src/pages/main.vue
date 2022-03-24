<template>
  <div class="main">
    <template v-for="item in sections" :key="item.name">
      <component
        :is="`section-${item.name}`"
        v-scroll="item.name == section"
        v-viewport="(inView, ratio) => onViewportDebounced(item, inView, ratio)"
        class="main__section"
        :data-theme="item.theme"
        :next-section="sections[sectionsIndex[item.name] + 1]"
      >
        <template #default="{next}">
          <Scroll v-if="next" :label="next.label" :link="next.link" />
        </template>
      </component>
    </template>
  </div>
</template>

<script>
import SectionMain from '../components/sections/Main.vue';
import SectionMust from '../components/sections/Must.vue';
import SectionTeletype from '../components/sections/Teletype.vue';
import SectionGithub from '../components/sections/GitHub.vue';

import Scroll from '../components/Scroll.vue';

import reduce from 'lodash/reduce';
import debounce from 'lodash/debounce';

export default {
  components: {
    SectionMain, SectionMust, SectionTeletype, SectionGithub,
    Scroll
  },

  computed: {
    sections() {
      return [
        { name: 'main', link: null, label: 'About' },
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
}
</style>
