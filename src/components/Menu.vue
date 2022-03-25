<template>
  <transition enter-from-class="m_hidden" leave-to-class="m_hidden">
    <nav v-if="visible" class="menu" :data-theme="view && view.theme">
      <div class="menu__wrap">
        <ul class="menu__list">
          <router-link
            v-for="item in sections" :key="item.name"
            v-slot="{ href, navigate }"
            :to="{ hash: `#${item.link}` }"
            custom
          >
            <li class="menu__item" :class="{'m_active': item.name === current}">
              <a :href="href" class="menu__item_link" @click="navigate">{{ item.label }}</a>
            </li>
          </router-link>
        </ul>
      </div>
    </nav>
  </transition>
</template>

<script>
export default {
  props: {
    'sections': { type: Array, default: () => []},
    'current':  { type: String, default: null },
    'inView':   { type: String, default: null },
    'visible':  { type: Boolean, default: false },
  },

  computed: {
    section() { return this.sections.find(item => item.name === this.current); },
    view() { return this.sections.find(item => item.name === this.inView); }
  }
};
</script>

<style lang="scss" scoped>
.menu {
  position: fixed;
  display: flex;
  flex-direction: row;
  align-items: flex-start;
  justify-content: center;
  top: 0;
  left: 0;
  right: 0;

  background: linear-gradient(to bottom, colors.get(bg) 20%, colors.get(bg-transparent) 100%);

  transition: all 0.2s;
  z-index: 2;

  &__wrap {
    display: flex;
    flex-direction: column;
    align-items: stretch;
    justify-content: flex-start;
    width: 100%;
    max-width: 500px;

    &::before {
      content: "";
      height: 3px;
      background: colors.get(primary);
      opacity: 0.4;
    }
  }

  &__list {
    display: flex;
    flex-direction: row;
    align-items: flex-start;
    justify-content: space-between;
    width: 100%;
    margin: 0;
    padding: 0;
    box-sizing: border-box;

    @include sizes.screen(mobile) {
      padding: 0 sizes.$margin;
    }
  }
  &__item {
    display: block;
    margin-top: -3px;

    opacity: 0.4;

    &_link {
      display: inline-block;
      padding: sizes.$gap;

      border-top: 3px solid transparent;

      @include fonts.sans(medium);
      @include sizes.font(18, 24);

      color: colors.get(primary);
      text-align: center;

      color: colors.get(primary);
      text-decoration: none;

      transition: all 0.4s;

      @include sizes.screen(mobile) {
      @include sizes.font(15);
    }
    }

    &:hover {
      opacity: 0.7;
    }
    &.m_active {
      opacity: 1;
    }
    &.m_active &_link {
      border-color: colors.get(primary);
    }
  }

  &.m_hidden {
    opacity: 0;
    transform: translateY(-10px);
  }
}
</style>
