<template>
  <SiteNav />

  <main>
    <HeroSection />
    <NowSection />
    <AiSection />
    <ProductsSection />
    <ProjectsSection />
    <OpenSourceSection />
  </main>

  <FooterSection />
</template>

<script setup>
import SiteNav from '../components/SiteNav.vue';
import HeroSection from '../sections/HeroSection.vue';
import NowSection from '../sections/NowSection.vue';
import AiSection from '../sections/AiSection.vue';
import ProductsSection from '../sections/ProductsSection.vue';
import ProjectsSection from '../sections/ProjectsSection.vue';
import OpenSourceSection from '../sections/OpenSourceSection.vue';
import FooterSection from '../sections/FooterSection.vue';
</script>
