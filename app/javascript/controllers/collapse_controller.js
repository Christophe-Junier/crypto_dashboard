import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="collapse"
export default class extends Controller {
  toggle(event) {
    const newState = this.element.dataset.expanded === "true" ? "false" : "true"
    this.element.dataset.expanded = newState
  }
}
