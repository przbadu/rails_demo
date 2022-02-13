import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="cashflow-filter"
export default class extends Controller {
  static targets = ['label', 'chart']
  static values = { type: String }

  filter(event) {
    event.preventDefault()
    const params = event.params
    const chart = Chartkick.charts['cashflowChart']

    fetch(params.url)
      .then(response => response.json())
      .then(data => {
        this.labelTarget.innerText = data.filter_text
        chart.updateData([{ label: 'Income', data: data.income }, { label: 'Expense', data: data.expense }])
      })
  }

}
