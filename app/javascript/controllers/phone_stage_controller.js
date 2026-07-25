import { Controller } from "@hotwired/stimulus";

// Scroll-driven "phone stage". A tall track pins the phone while its screen
// advances, driven continuously from scroll progress.
//
// Desktop: a subtle zoom (START_DESKTOP -> 1), frame always visible, then the
// hero -> features crossfade and the card feed.
//
// Mobile: the phone "opens" into fullscreen in three beats, then plays content:
//   1. Zoom to fill the viewport width (no horizontal crop/over-magnification).
//   2. Grow the screen top/bottom to fullscreen while the frame fades out, so
//      the content reflows crisp and fills the viewport (no letterbox, works
//      with the light hero).
//   3. Hero -> features crossfade, then the card feed scrolls.
const START_MOBILE = 0.8;
const START_DESKTOP = 0.92;
const FILL_MARGIN = 1.02; // a hair of overscale so no sliver of frame remains
// At/above this width the phone stays framed (tablets + desktop); below it the
// phone goes fullscreen (true phones only). Must match the `min-[500px]:`
// breakpoint used for the phone sizing in the view.
const DESKTOP_QUERY = "(min-width: 500px)";

// Mobile phase boundaries (fractions of the whole track).
const M_ZOOM_END = 0.08;
const M_GROW_END = 0.16;
const M_CF_END = 0.24;
// Desktop phase boundaries: zoom finishes before the hero starts to fade.
const D_ZOOM_END = 0.08;
const D_CF_END = 0.18;
const COVER_MARGIN = 1.04; // content overscans the viewport height so no bars show

// Card feed.
const LEAD = 0.9; // feed start offset (viewport heights) so every card enters
const TRAIL = 0.25; // extra travel so the last card fully arrives
const REVEAL_SPAN = 0.4; // viewport heights over which a card fully reveals
const SLIDE = 80; // % of card width a card is offset while hidden

// Screen hole geometry (percent) — matches the inline style in the view.
const HOLE = { top: 4.6, bottom: 5, left: 2.6, right: 2.7, rH: 7, rV: 3.2 };

export default class extends Controller {
  static targets = [
    "track", "phone", "screen", "frame", "heroScreen", "featuresScreen", "list", "card", "cta",
    "floater",
  ];

  connect() {
    this.reduced = window.matchMedia("(prefers-reduced-motion: reduce)").matches;
    this.ticking = false;
    this.onScroll = this.requestUpdate.bind(this);
    this.onResize = this.handleResize.bind(this);
    window.addEventListener("scroll", this.onScroll, { passive: true });
    window.addEventListener("resize", this.onResize);
    this.update();
    this.setFloat(this.isDesktop() ? "running" : "off");
  }

  handleResize() {
    this.update();
    this.setFloat(this.isDesktop() ? "running" : "off");
  }

  disconnect() {
    window.removeEventListener("scroll", this.onScroll);
    window.removeEventListener("resize", this.onResize);
    clearTimeout(this.idleTimer);
  }

  requestUpdate() {
    this.pauseFloatWhileScrolling();
    if (this.ticking) return;
    this.ticking = true;
    requestAnimationFrame(() => {
      this.update();
      this.ticking = false;
    });
  }

  isDesktop() {
    return window.matchMedia(DESKTOP_QUERY).matches;
  }

  // Idle float runs only on the framed (tablet/desktop) layout; on the
  // fullscreen mobile layout it's off entirely, since bobbing would shift the
  // whole screen. Modes: "running" | "paused" | "off".
  setFloat(mode) {
    if (!this.hasFloaterTarget) return;
    const style = this.floaterTarget.style;
    if (this.reduced || mode === "off") {
      style.animation = "none";
      return;
    }
    style.animation = "";
    style.animationPlayState = mode;
  }

  // The phone floats (idle bob) only when the page isn't being scrolled: pause
  // on scroll, resume a moment after scrolling stops — and never on mobile.
  pauseFloatWhileScrolling() {
    this.setFloat(this.isDesktop() ? "paused" : "off");
    clearTimeout(this.idleTimer);
    this.idleTimer = setTimeout(() => {
      this.setFloat(this.isDesktop() ? "running" : "off");
    }, 200);
  }

  update() {
    const isDesktop = window.matchMedia(DESKTOP_QUERY).matches;
    const maxScroll = this.trackTarget.offsetHeight - window.innerHeight;
    const scrolled = clamp(
      -this.trackTarget.getBoundingClientRect().top,
      0,
      Math.max(maxScroll, 0)
    );
    const progress = maxScroll > 0 ? scrolled / maxScroll : 0;

    let cf, featuresLocal;

    if (isDesktop || this.reduced) {
      // Framed the whole time; subtle zoom, then the hero fades (only after the
      // zoom is done), then the feed.
      const zoomT = clamp(progress / D_ZOOM_END, 0, 1);
      const scale = this.reduced ? 1 : START_DESKTOP + (1 - START_DESKTOP) * zoomT;
      this.phoneTarget.style.transform = `scale(${scale})`;
      this.setInsets(0);
      if (this.hasFrameTarget) this.frameTarget.style.opacity = "1";
      cf = clamp((progress - D_ZOOM_END) / (D_CF_END - D_ZOOM_END), 0, 1);
      featuresLocal = clamp((progress - D_CF_END) / (1 - D_CF_END), 0, 1);
    } else {
      // Mobile: zoom -> grow + fade frame -> content.
      const zoomT = clamp(progress / M_ZOOM_END, 0, 1);
      const growT = clamp((progress - M_ZOOM_END) / (M_GROW_END - M_ZOOM_END), 0, 1);
      const scale = START_MOBILE + (this.mobileFillScale() - START_MOBILE) * zoomT;
      this.phoneTarget.style.transform = `scale(${scale})`;
      this.setInsets(growT, this.coverInset(scale));
      if (this.hasFrameTarget) this.frameTarget.style.opacity = String(1 - growT);
      cf = clamp((progress - M_GROW_END) / (M_CF_END - M_GROW_END), 0, 1);
      featuresLocal = clamp((progress - M_CF_END) / (1 - M_CF_END), 0, 1);
    }

    this.heroScreenTarget.style.opacity = String(1 - cf);
    this.featuresScreenTarget.style.opacity = String(cf);
    this.updateFeed(featuresLocal);
  }

  // Scale at which the screen area fills the viewport width (measured live).
  mobileFillScale() {
    const pw = this.hasPhoneTarget ? this.phoneTarget.offsetWidth : 0;
    if (!pw) return 1.1;
    const holeW = pw * (1 - (HOLE.left + HOLE.right) / 100);
    return (window.innerWidth / holeW) * FILL_MARGIN;
  }

  // Top/bottom inset (percent, usually negative) the screen must reach so that,
  // at the given scale, it overscans the viewport height — no black bars.
  coverInset(scale) {
    const ph = this.hasPhoneTarget ? this.phoneTarget.offsetHeight : 0;
    if (!ph || !scale) return 0;
    const coverFrac = (window.innerHeight * COVER_MARGIN) / (ph * scale);
    return Math.min((1 - coverFrac) * 50, 0);
  }

  // Interpolate the screen from the frame hole (t=0) to fullscreen (t=1).
  // Left/right stay at the hole so width stays filled without cropping; top and
  // bottom grow to `endTB` (which overscans the viewport so no bars show).
  setInsets(t, endTB = 0) {
    if (!this.hasScreenTarget) return;
    const s = this.screenTarget.style;
    s.top = `${lerp(HOLE.top, endTB, t)}%`;
    s.bottom = `${lerp(HOLE.bottom, endTB, t)}%`;
    s.left = `${HOLE.left}%`;
    s.right = `${HOLE.right}%`;
    s.borderRadius = `${lerp(HOLE.rH, 0, t)}% / ${lerp(HOLE.rV, 0, t)}%`;
  }

  updateFeed(featuresLocal) {
    if (!this.hasListTarget) return;
    const viewport = this.listTarget.parentElement;
    const vh = viewport.clientHeight;
    // The closing CTA fills a full phone screen.
    if (this.hasCtaTarget) this.ctaTarget.style.minHeight = `${vh}px`;
    const range = Math.max(this.listTarget.scrollHeight - vh, 0);
    const lead = vh * LEAD;
    const travel = lead + range + vh * TRAIL;
    // Clamp so the feed never scrolls past its natural bottom: the closing CTA
    // fills the screen exactly (content centered) and the TRAIL acts as a hold.
    const listY = Math.max(lead - travel * featuresLocal, -range);
    this.listTarget.style.transform = `translate3d(0, ${listY}px, 0)`;
    this.revealCards(vh, listY);
  }

  // Each card slides in from its side and fades in as it rises into the screen.
  revealCards(viewportHeight, listY) {
    const span = viewportHeight * REVEAL_SPAN;
    for (const card of this.cardTargets) {
      const topInViewport = card.offsetTop + listY;
      const revealT = clamp((viewportHeight - topInViewport) / span, 0, 1);
      const sign = card.dataset.from === "left" ? -1 : 1;
      const x = this.reduced ? 0 : sign * SLIDE * (1 - revealT);
      card.style.transform = `translateX(${x}%)`;
      card.style.opacity = this.reduced ? "1" : String(revealT);
    }
  }
}

function clamp(value, min, max) {
  return Math.min(Math.max(value, min), max);
}

function lerp(a, b, t) {
  return a + (b - a) * t;
}
