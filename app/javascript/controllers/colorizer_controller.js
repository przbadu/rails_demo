import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { color: String }

  connect() {
    const backgroundColor = this.hexToRGB(this.colorValue, 0.1)
    this.element.style.backgroundColor = backgroundColor
    this.element.style.color = "#" + this.colorValue
  }

  hexToRGB(hex, alpha) {
    var r = parseInt(hex.slice(1, 3), 16),
    g = parseInt(hex.slice(3, 5), 16),
    b = parseInt(hex.slice(5, 7), 16);

    if (alpha) {
      return "rgba(" + r + ", " + g + ", " + b + ", " + alpha + ")";
    } else {
      return "rgb(" + r + ", " + g + ", " + b + ")";
    }
  }

}
