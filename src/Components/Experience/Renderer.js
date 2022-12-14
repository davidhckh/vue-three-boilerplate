import { WebGLRenderer, VSMShadowMap } from "three";
import Experience from "./Experience.js";

export default class Renderer {
  constructor() {
    this.experience = new Experience();
    this.canvas = this.experience.canvas;
    this.sizes = this.experience.sizes;
    this.scene = this.experience.scene;
    this.camera = this.experience.camera;

    this.setInstance();
  }

  setInstance() {
    this.instance = new WebGLRenderer({
      canvas: this.canvas,
      antialias: this.sizes.portrait === true ? false : true,
      powerPreference: "high-performance",
    });

    this.instance.setClearColor("#A7D4E2", 1);
    this.instance.shadowMap.enabled = true;
    this.instance.shadowMap.type = VSMShadowMap;

    this.resize();
  }

  resize() {
    this.instance.setSize(this.sizes.width, this.sizes.height);
    this.instance.setPixelRatio(Math.min(this.sizes.pixelRatio, 2));
  }

  update() {
    this.instance.render(this.scene, this.camera.instance);
    //console.log(this.instance.info.render.calls);
  }
}
