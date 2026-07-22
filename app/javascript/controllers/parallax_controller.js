import { Controller } from "@hotwired/stimulus";

// Hero scroll effect: both layers drift upward (along the scroll axis) at
// different speeds to create depth, and fade out as the hero hands off to the
// section below. The phone moves slower (it sits "behind"); the text moves and
// fades a touch faster (it sits "in front"). Transforms are applied to the
// wrapper elements, so the phone's idle float animation on the inner <img> is
// left untouched.
export default class extends Controller {
  static targets = ["phone", "content"];

  connect() {
    this.ticking = false;
    this.onScroll = this.requestUpdate.bind(this);
    window.addEventListener("scroll", this.onScroll, { passive: true });
    this.update();
  }

  disconnect() {
    window.removeEventListener("scroll", this.onScroll);
  }

  requestUpdate() {
    if (this.ticking) return;
    this.ticking = true;
    requestAnimationFrame(() => {
      this.update();
      this.ticking = false;
    });
  }

  update() {
    // Only run the effect on the side-by-side desktop layout. On the stacked
    // mobile layout it looks off, so leave the elements static there.
    if (window.innerWidth < 1172) {
      this.reset();
      return;
    }

    const y = window.scrollY;
    const vh = window.innerHeight || 800;

    if (this.hasPhoneTarget) {
      this.phoneTarget.style.transform = `translateY(${-y * 0.15}px)`;
      this.phoneTarget.style.opacity = Math.max(0, 1 - y / (vh * 0.85));
    }

    if (this.hasContentTarget) {
      this.contentTarget.style.transform = `translateY(${-y * 0.4}px)`;
      this.contentTarget.style.opacity = Math.max(0, 1 - y / (vh * 0.6));
    }
  }

  reset() {
    const targets = [];
    if (this.hasPhoneTarget) targets.push(this.phoneTarget);
    if (this.hasContentTarget) targets.push(this.contentTarget);
    for (const target of targets) {
      target.style.transform = "";
      target.style.opacity = "";
    }
  }
}
