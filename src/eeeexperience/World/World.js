import Experience from "../Experience.js";
import Test from "./Test.js";

export default class World {
  constructor() {
    this.experience = new Experience();
    this.scene = this.experience.scene;
    this.resources = this.experience.resources;

    this.resources.on("ready", () => {
      this.isReady = true;
      this.test = new Test();
    });
  }

  update() {
    if (this.isReady !== true) return;

    this.test.update();
  }
}
