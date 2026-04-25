import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["phone", "content"];

  connect() {
    this.onScroll = this.update.bind(this);
    window.addEventListener("scroll", this.onScroll, { passive: true });
  }

  disconnect() {
    window.removeEventListener("scroll", this.onScroll);
  }

  update() {
    const y = window.scrollY;

    if (window.innerWidth < 1172) {
      if (this.hasPhoneTarget) {
        this.phoneTarget.style.transform = `translateY(${-y * 0.3}px)`;
      }
      if (this.hasContentTarget) {
        this.contentTarget.style.transform = "";
        this.contentTarget.style.opacity = Math.max(0, 1 - y / 250);
      }
    } else {
      if (this.hasPhoneTarget) {
        this.phoneTarget.style.transform = `translateY(${-y * 0.5}px)`;
      }
      if (this.hasContentTarget) {
        this.contentTarget.style.opacity = "";
        this.contentTarget.style.transform = `translateY(${y * 0.2}px)`;
      }
    }
  }
}
