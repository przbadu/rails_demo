import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="icon-picker"
export default class extends Controller {
  static targets = ['input']

  click(event) {
    event.preventDefault()
    document.querySelectorAll('.icon-picker-item').forEach(el => {
      el.classList.remove('text-white')
      el.classList.remove('bg-success')
    })

    let target;
    if (event.target.nodeName === 'I') {
      target = event.target.parentElement
    } else {
      target = event.target
    }

    target.classList.add('text-white')
    target.classList.add('bg-success')
    this.inputTarget.value = target.dataset.icon
  }
}
