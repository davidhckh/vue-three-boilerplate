import Experience from "../Experience";
import { Mesh, BoxGeometry, MeshMatcapMaterial } from "three";

export default class Test {
  constructor() {
    this.experience = new Experience();
    this.resources = this.experience.resources;
    this.scene = this.experience.scene;
    this.time = this.experience.time;

    this.setMaterial();
    this.setMesh();
  }

  setMaterial() {
    this.material = new MeshMatcapMaterial({
      matcap: this.resources.items.blackMatcap,
    });
  }

  setMesh() {
    this.mesh = this.resources.items.testModel.scene.children[0];

    this.mesh.material = this.material;

    this.scene.add(this.mesh);
  }

  update() {
    this.mesh.rotation.y += 0.005 * (this.time.delta / 16);
    this.mesh.rotation.x += 0.005 * (this.time.delta / 16);
  }
}
