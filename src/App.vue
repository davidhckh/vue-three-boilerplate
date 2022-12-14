<script>
import IconSpritesheet from "./IconSpritesheet.vue";
import Canvas from "./Components/Canvas.vue";

import { store } from "./content/store.js";

export default {
  data() {
    return {
      store,
    };
  },
  components: {
    IconSpritesheet,
    Canvas,
  },
};
</script>

<template>
  <IconSpritesheet />
  <aside>
    <Canvas></Canvas>
  </aside>
</template>

<style scoped lang="scss">
.wrapper {
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

  @include mq("sm") {
    width: 80vw;
  }
}
</style>
