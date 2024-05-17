<script setup lang="ts">
const { data } = await useFetch('/api/hello')
definePageMeta({
  layout: "landing",
});
</script>

<template>
  <pre>{{ data }}</pre>
  <LandingContainer>
    <LandingHero></LandingHero>
    <LandingFeatures></LandingFeatures>
    <LandingLogos></LandingLogos>
    <LandingCta></LandingCta>
  </LandingContainer>
</template>