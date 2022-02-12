import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dashboard-amount-loader"
export default class extends Controller {
  static targets = ['amount', 'filter']
  static values = { type: String }

  load(event) {
    const params = event.params
    event.preventDefault()

    fetch(params.url)
      .then(response => response.json())
      .then(data => {
        this.amountTarget.innerText = data.amount
        this.filterTarget.innerText = data.filter_text
      })
  }
}
