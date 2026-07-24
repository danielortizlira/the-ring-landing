import { Controller } from "@hotwired/stimulus";

// Hero reveal effect: each target slides in from the side it "came from" (phone
// from the left, text from the right) and fades in when it enters the viewport,
// and slides back out that same way when it leaves. Visibility is decided
// per-element via IntersectionObserver, so it works in the stacked mobile layout
// too. The transform is applied to the wrapper <div>, leaving the phone's idle
// float animation on the inner <img> untouched.
const OFFSET = 180; // px the element is offset in its origin direction while hidden

export default class extends Controller {
  static targets = ["phone", "content"];

  connect() {
    // Respect reduced-motion: leave everything at its natural, visible position.
    if (window.matchMedia("(prefers-reduced-motion: reduce)").matches) return;

    // Negative top/bottom rootMargin shrinks the viewport the observer cares
    // about, so an element counts as "gone" while it's still ~25% on screen —
    // that's what makes the slide-out actually visible before it scrolls off.
    this.observer = new IntersectionObserver(this.onIntersect.bind(this), {
      threshold: 0,
      rootMargin: "-25% 0px -25% 0px",
    });

    for (const target of this.revealTargets) {
      this.hide(target);
      this.observer.observe(target);
    }
  }

  disconnect() {
    if (this.observer) this.observer.disconnect();
  }

  get revealTargets() {
    const targets = [];
    if (this.hasPhoneTarget) targets.push(this.phoneTarget);
    if (this.hasContentTarget) targets.push(this.contentTarget);
    return targets;
  }

  onIntersect(entries) {
    for (const entry of entries) {
      if (entry.isIntersecting) {
        this.show(entry.target);
      } else {
        this.hide(entry.target);
      }
    }
  }

  hide(el) {
    const dx = el.dataset.parallaxFrom === "left" ? -OFFSET : OFFSET;
    el.style.opacity = "0";
    el.style.transform = `translateX(${dx}px)`;
  }

  show(el) {
    el.style.opacity = "1";
    el.style.transform = "translateX(0)";
  }
}
