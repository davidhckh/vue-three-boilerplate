<script setup>
import Experience from "../experience/Experience";
import { onMounted, ref } from "vue";

const canvas = ref(null);

onMounted(() => {
  const experience = new Experience(canvas.value);
});
</script>

<template>
  <canvas class="webgl-canvas" ref="canvas" />
</template>

<style scoped lang="scss">
.webgl-canvas {
  @extend %cover;
}
</style>
