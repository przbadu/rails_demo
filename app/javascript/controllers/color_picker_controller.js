import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="color-picker"
export default class extends Controller {
  static targets = ['input']

  click(event) {
    const color = event.target.dataset?.color
    this.inputTarget.value = color
  }
}
