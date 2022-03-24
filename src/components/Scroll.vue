<template>
  <router-link
    v-slot="{ href, navigate }"
    :to="{ hash: `#${link}` }"
    custom
  >
    <a :href="href" class="scroll" @click="ev => onClick(navigate, ev)">
      <icon-scroll class="scroll__icon" />

      <div v-if="label" class="scroll__label">
        {{ label }}
      </div>
    </a>
  </router-link>
</template>

<script>
import IconScroll from '../../assets/images/icon_scroll.svg?component';

export default {
  components: { IconScroll },

  props: {
    label: { type: String, default: '' },
    link: { type: String, default: '' },
  },

  emits: ['click'],

  methods: {
    onClick(navigate, ev) {
      this.$emit('click');
      navigate(ev);
    }
  }
};
</script>

<style lang="scss" scoped>
.scroll {
  display: block;
  width: 100%;
  max-width: sizes.$column;
  margin: 0;
  padding: sizes.$margin;
  box-sizing: border-box;

  text-decoration: none;
  cursor: pointer;

  &__icon {
    display: block;
    width: sizes.$ui;
    height: sizes.$ui;
    margin: 0 auto;
    vertical-align: top;
    color: colors.get(primary);

    transition: all 0.4s;

    @keyframes scroll-icon {
        0% { transform: translateY(0); }
       25% { transform: translateY(-2px); }
       75% { transform: translateY(2px); }
      100% { transform: translateY(0); }
    }

    animation: scroll-icon 3s linear infinite;
  }
  &__label {
    display: block;

    @include fonts.sans();
    @include sizes.font(20, 24);

    text-align: center;
    color: colors.get(primary);
  }

  &:hover &__icon {
    animation: none;
  }
}
</style>
