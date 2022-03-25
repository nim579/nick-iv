<template>
  <section class="sectionGithub">
    <div class="sectionGithub__content">
      <h2 class="sectionGithub__title">
        GitHub Projects
      </h2>

      <div class="sectionGithub__projects">
        <a
          v-for="project in projects" :key="project.name"
          class="sectionGithub__project"
          :href="project.link"
        >
          <div class="sectionGithub__project_art">
            <span>{{ project.name }}</span>
          </div>
          <div class="sectionGithub__project_description">
            {{ project.description }}
          </div>
        </a>
      </div>
    </div>

    <slot :next="nextSection" />
  </section>
</template>

<script>
export default {
  props: {
    nextSection: { type: Object, default: null }
  },

  data: () => ({
    projects: [
      {
        name: 'Fractals',
        description: 'T-fractals web generator',
        link: 'https://github.com/nim579/fractals'
      }, {
        name: 'node-srv',
        description: 'Ligntweight static node.js server',
        link: 'https://github.com/nim579/node-srv'
      }, {
        name: 'dns_relay',
        description: 'DNS relay for UDP and DoH requests',
        link: 'https://github.com/nim579/dns_relay'
      }, {
        name: 'setup.js',
        description: 'Projects environment configurator',
        link: 'https://github.com/nim579/setup.js'
      }, {
        name: 'slack-send-cli',
        description: 'Slack CLI sending messages by webhook',
        link: 'https://github.com/nim579/slack-send-cli'
      }, {
        name: 'do-migrate',
        description: 'PostgreSQL migration tool on Node.js ',
        link: 'https://github.com/nim579/do-migrate'
      }
    ]
  })
};
</script>

<style lang="scss" scoped>
.sectionGithub {
  &__content {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: flex-start;
    margin: auto;
    padding: 80px sizes.$margin 60px;

    @include sizes.screen() {
      padding-bottom: sizes.$margin;
    }
  }

  &__title {
    display: block;
    margin: 0 0 34px;

    @include fonts.sans();
    @include sizes.font(34);

    color: colors.get(primary);
    text-align: center;
  }

  &__projects {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    grid-gap: sizes.$margin;

    @include sizes.screen(mobile) {
      grid-template-columns: repeat(2, 1fr);
    }
  }
  &__project {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: flex-start;
    max-width: 250px;
    text-decoration: none;

    &_art {
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      width: 160px;
      height: 160px;
      padding: sizes.$gap;
      box-sizing: border-box;

      background-color: colors.get(border);
      @include ui.mask-image();

      @include fonts.sans(semibold);
      @include sizes.font(22, 22);

      color: colors.get(secondary);
      text-align: center;
      text-transform: uppercase;

      @include sizes.screen(mobile) {
        width: 120px;
        height: 120px;
        @include sizes.font(18, 18);
      }
    }
    &_description {
      display: inline-block;
      margin-top: sizes.$gap;

      @include fonts.sans();
      @include sizes.font(18);

      color: colors.get(primary);
      text-align: center;

      @include sizes.screen(mobile) {
        @include sizes.font(15);
      }
    }


  }
}
</style>
