<script>
import Experience from "./Experience/Experience";
import { store } from "@/content/store";

export default {
  name: "Canvas",
  mounted() {
    new Experience(this.$refs.canvas);
  },
};
</script>

<template>
  <div class="webgl-wrapper">
    <canvas class="webgl-canvas" ref="canvas"></canvas>
  </div>
</template>

<style scoped lang="scss">
.webgl-canvas {
  @extend %cover;
}
</style>
