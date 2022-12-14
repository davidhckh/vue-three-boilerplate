import { Vector3, PerspectiveCamera } from "three";
import Experience from "./Experience.js";
import { OrbitControls } from "three/examples/jsm/controls/OrbitControls.js";
import { lerp } from "./Utils/math.js";
import { store } from "@/content/store";

export default class Camera {
  constructor() {
    this.experience = new Experience();
    this.sizes = this.experience.sizes;
    this.scene = this.experience.scene;
    this.canvas = this.experience.canvas;
    this.debug = this.experience.debug;
    this.resources = this.experience.resources;

    this.sizes.on("orientationChange", () => {});

    this.setInstance();
    this.unlockControls();
    this.initDebug();
  }

  setInstance() {
    this.instance = new PerspectiveCamera(50, this.sizes.width / this.sizes.height, 0.1, 1000);

    this.instance.position.set(5, 5, 5);
    this.scene.add(this.instance);
  }

  resize() {
    this.instance.aspect = this.sizes.width / this.sizes.height;
    this.instance.updateProjectionMatrix();
  }

  /**
   * DEBUG
   */

  update() {
    this.debug.active === true && this.updateDebug();
  }

  unlockControls() {
    this.controls = new OrbitControls(this.instance, this.canvas);
    this.controls.enableDamping = true;
  }

  initDebug() {
    if (this.debug.active) {
      this.config = {
        logPosition: false,
        logRotation: false,
      };

      this.debugFolder = this.debug.ui.addFolder("Camera");
      this.debugFolder.add(this, "unlockControls").name("Unlock controls");
      this.debugFolder.add(this.config, "logPosition").name("Log position");
      this.debugFolder.add(this.config, "logRotation").name("Log rotation");
    }
  }

  updateDebug() {
    this.controls != null && this.controls.update();
    this.config.logPosition === true && console.log(this.instance.position);
    this.config.logRotation === true && console.log(this.instance.rotation);
  }
}
