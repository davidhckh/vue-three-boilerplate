import EventEmitter from "./EventEmitter.js";

export default class Time extends EventEmitter {
  constructor() {
    super();

    this.start = Date.now();
    this.current = this.start;
    this.elapsed = 0;
    this.delta = 16;

    window.requestAnimationFrame(() => this.tick());

    //reset current on reopen to prevent bugs
    window.addEventListener("focus", () => (this.current = Date.now()));
  }

  tick() {
    const currentTime = Date.now();
    this.delta = currentTime - this.current;
    this.current = currentTime;
    this.elapsed = (this.current - this.start) * 0.001;

    this.trigger("tick");

    //repeat
    window.requestAnimationFrame(() => this.tick());
  }
}
