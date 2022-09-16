import ApplicationController from 'controllers/application_controller';

export default class extends ApplicationController {
  static values = {
    initial: Boolean,
    destroy: Boolean
  };
  observer = null; //: MutationObserver;
  currentDisplayStyle = null; //: string;

  get hasDestroyValue() {
    return this.destroyValue;
  }

  get hasInitialValue() {
    return this.initialValue;
  }

  initialize() {
    this.observer = new MutationObserver((mutations) => {
      this.observer.disconnect();
      this.verifyChange.call(this, mutations);
    });
    if (this.hasInitialValue) this.enter();
    else this.startObserver();
  }

  async enter() {
    await this.runTransition("enter");
    this.dispatchEnd("enter");
    this.startObserver();
  }

  async leave(attribute) {
    // Cancel out the display style
    if (attribute === "hidden") this.element.hidden = false;
    else this.displayStyle = this.currentDisplayStyle;

    await this.runTransition("leave");

    // Restore the display style to previous value
    if (attribute === "hidden") this.element.hidden = true;
    else this.displayStyle = attribute === "style" ? "none" : undefined;

    this.dispatchEnd("leave");

    // Destroy element, or restart observer
    if (this.hasDestroyValue) this.element.remove();
    else this.startObserver();
  }

  // Helpers for transition
  nextFrame() {
    return new Promise((resolve) => {
      requestAnimationFrame(() => {
        requestAnimationFrame(resolve);
      });
    });
  }

  afterTransition() {
    return new Promise((resolve) => {
      const duration =
        Number(
          getComputedStyle(this.element)
            .transitionDuration.split(",")[0]
            .replace("s", "")
        ) * 1000;

      setTimeout(() => {
        resolve();
      }, duration);
    });
  }

  async runTransition(dir) {
    const activeClasses = this.getTransitionClasses(`${dir}-active`);
    const fromClasses = this.getTransitionClasses(`${dir}-from`);
    const toClasses = this.getTransitionClasses(`${dir}-to`);

    this.element.classList.add(...activeClasses);
    this.element.classList.add(...fromClasses);

    await this.nextFrame();

    this.element.classList.remove(...fromClasses);
    this.element.classList.add(...toClasses);

    await this.afterTransition();

    this.element.classList.remove(...toClasses);
    this.element.classList.remove(...activeClasses);
  }

  getTransitionClasses(name) {
    return (
      this.element.getAttribute(`data-transition-${name}`)?.split(" ") ?? []
    );
  }

  dispatchEnd(dir) {
    const type = `transition:end-${dir}`;
    const event = new CustomEvent(type, { bubbles: true, cancelable: true });
    this.element.dispatchEvent(event);
    return event;
  }

  get display() {
    return getComputedStyle(this.element)["display"];
  }

  set displayStyle(v) {
    v
      ? this.element .style.setProperty("display", v)
      : this.element .style.removeProperty("display");
  }

  // Helpers for observer
  verifyChange(mutations) {
    const newDisplayStyle = this.display;

    // Make sure there is a new computed displayStyle && the it was or will be "none"
    if (
      newDisplayStyle !== this.currentDisplayStyle &&
      (newDisplayStyle === "none" || this.currentDisplayStyle === "none")
    )
      newDisplayStyle === "none"
        ? this.leave(mutations[0].attributeName)
        : this.enter();
    else this.startObserver();
  }

  startObserver() {
    this.currentDisplayStyle = this.display;
    if (this.element.isConnected)
      this.observer.observe(this.element, {
        attributeFilter: ["class", "hidden", "style"],
      });
  }
}