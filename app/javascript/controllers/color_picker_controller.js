import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="color-picker"
export default class extends Controller {
  static targets = ['input']

  click(event) {
    event.preventDefault()
    document.querySelectorAll('.color-picker-item').forEach(el => el.innerHTML = null)
    const target = event.target

    const iconEl = document.createElement('i')
    iconEl.classList.add('mdi')
    iconEl.classList.add('mdi-check')
    target.appendChild(iconEl)
    this.inputTarget.value = target.dataset.color
  }
}
