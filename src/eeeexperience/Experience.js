import { Scene } from "three";

import Debug from "./Utils/Debug.js";
import Sizes from "./Utils/Sizes.js";
import Time from "./Utils/Time.js";
import Camera from "./Camera.js";
import Renderer from "./Renderer.js";
import World from "./World/World.js";
import Resources from "./Utils/Resources.js";

let instance = null;

export default class Experience {
  constructor(_canvas) {
    //singleton
    if (instance) return instance;
    instance = this;

    this.canvas = _canvas;

    this.debug = new Debug();
    this.sizes = new Sizes();
    this.time = new Time();
    this.scene = new Scene();
    this.resources = new Resources();
    this.world = new World();
    this.camera = new Camera();
    this.renderer = new Renderer();

    this.sizes.on("resize", () => this.resize());
    this.time.on("tick", () => this.update());
  }

  resize() {
    this.camera.resize();
    this.renderer.resize();
  }

  update() {
    this.camera.update();
    this.world.update();
    this.renderer.update();
  }
}
