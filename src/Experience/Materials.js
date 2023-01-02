import { ShaderMaterial, UniformsLib, Vector3 } from "three";

import Experience from "./Experience";

export default class Materials {
  constructor() {
    this.experience = new Experience();
    this.resources = this.experience.resources;

    this.resources.on("ready", () => {});
  }

  update() {}
}
