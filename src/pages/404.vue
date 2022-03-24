<template>
  <div class="errorPage">
    <h1 class="errorPage__title">
      404
    </h1>
    <p class="errorPage__text">
      Page not found
    </p>
    <router-link :to="{name: 'main'}" class="errorPage__link">
      &larr; <span class="errorPage__link_text">To main page</span>
    </router-link>
  </div>
</template>

<script>
export default {};
</script>

<style lang="scss" scoped>
.errorPage {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  min-height: 100vh;
  max-height: 100%;
  padding: sizes.$margin;
  box-sizing: border-box;

  background: colors.get(bg);
  color: colors.get(primary);

  &__title {
    display: block;
    margin: 0;

    @include fonts.sans(semobild);
    @include sizes.font(120, 120);

    color: colors.get(primary);
    text-align: center;
  }
  &__text {
     display: block;
    margin: 0;

    @include fonts.sans(medium);
    @include sizes.font(35, 35);

    color: colors.get(primary);
    text-align: center;
  }

  &__link {
    display: block;
    margin-top: sizes.$margin;

    @include fonts.sans();
    @include sizes.font(22);

    color: colors.get(primary);
    text-align: center;
    text-decoration: none;

    &_text {
      text-decoration: underline;
    }
  }
}
</style>
