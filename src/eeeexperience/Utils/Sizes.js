import EventEmitter from "./EventEmitter.js";


export default class Sizes extends EventEmitter {
  constructor() {
    super();

    this.updateSizes();

    window.addEventListener("resize", () => {
      this.updateSizes();
      this.trigger("resize");
    });
  }

  updateSizes() {
    this.width = window.innerWidth;
    this.height = window.innerHeight;
    this.pixelRatio = Math.min(window.devicePixelRatio, 2);

    document.documentElement.style.setProperty("--100vh", `${this.height}px`);

    this.checkPortrait();
  }

  checkPortrait() {
    const isPortrait = this.width < 768;

    if (isPortrait !== this.portrait) {
      this.portrait = isPortrait;
      window.requestAnimationFrame(() => this.trigger("orientationChange"));
    }
  }
}
