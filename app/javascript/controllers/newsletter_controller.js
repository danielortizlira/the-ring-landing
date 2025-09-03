import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["button"];

  disableButton() {
    this.buttonTarget.disabled = true;
  }

  enableButton() {
    this.buttonTarget.disabled = false;
  }
}
