import Experience from "../Experience.js";
import { Mesh, BoxGeometry, MeshMatcapMaterial } from "three";

export default class World {
  constructor() {
    this.experience = new Experience();
    this.scene = this.experience.scene;
    this.resources = this.experience.resources;

    this.resources.on("ready", () => {
      this.cube = new Mesh(
        new BoxGeometry(1, 1, 1),
        new MeshMatcapMaterial({
          matcap: this.resources.items.blackMatcap,
        })
      );

      this.cube.position.set(0, 0, 0);
      this.cube.scale.set(1, 1, 1);

      this.scene.add(this.cube);
    });
  }

  update() {}
}
