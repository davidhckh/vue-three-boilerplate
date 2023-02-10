<script setup>
import Experience from "./components/Experience.vue";
</script>

<template>
  <div class="uiWrapper"></div>
  <aside>
    <Experience></Experience>
  </aside>
</template>

<style scoped lang="scss">
.uiWrapper {
  @extend %cover;

  left: 0;
  right: 0;
  margin: 0 auto;
  z-index: 1;
  width: 94vw;
  max-width: 80rem;
  pointer-events: none;

  * {
    pointer-events: all;
  }
}
</style>
