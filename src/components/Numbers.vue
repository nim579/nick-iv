<template>
  <ul class="numbers" :class="{'m_center': center}">
    <li
      v-for="(item, index) in data" :key="index"
      class="numbers__item"
    >
      <div class="numbers__item_label">
        {{ item.label }}
      </div>
      <div class="numbers__item_value">
        {{ item.value }}
      </div>
    </li>
  </ul>
</template>

<script>
export default {
  props: {
    data: { type: Array, required: true },
    center: { type: Boolean, default: false }
  }
};
</script>

<style lang="scss" scoped>
.numbers {
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  align-items: flex-end;
  justify-content: space-between;
  margin: 0 (sizes.$margin * -1) (sizes.$gap * -1) 0;
  padding: 0;

  list-style-type: none;

  &__item {
    display: block;
    flex: 0 0 auto;
    max-width: 120px;
    margin: 0 sizes.$margin sizes.$gap 0;

    &_label {
      display: block;

      @include fonts.sans();
      @include sizes.font(15);

      color: colors.get(secondary);
      text-align: left;

      @include sizes.screen() {
        @include sizes.font(14);
      }
    }
    &_value {
      display: block;

      @include fonts.sans(semibold);
      @include sizes.font(45, 45);

      color: colors.get(primary);
      text-align: left;

      @include sizes.screen() {
        @include sizes.font(35, 35);
      }
    }
  }

  &.m_center {
    justify-content: center;
  }

  @include sizes.screen() {
    justify-content: center;
  }
}
</style>
