import { Controller } from "@hotwired/stimulus"
import Choices from 'choices.js'

// Connects to data-controller="choice-select"
export default class extends Controller {
  static targets = ['select']
  static values = { option: Array }

  connect() {
    new Choices(this.selectTarget, {
      items: this.optionValue
    })
  }
}
