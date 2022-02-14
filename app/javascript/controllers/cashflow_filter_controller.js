import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="cashflow-filter"
export default class extends Controller {
  static targets = ['label', 'chart']

  filter(event) {
    event.preventDefault()
    const params = event.params
    const chartId = this.element.dataset.chartId
    const chart = Chartkick.charts[chartId]

    fetch(params.url)
      .then(response => response.json())
      .then(data => {
        this.labelTarget.innerText = data.filter_text
        chart.updateData([{ name: 'Income', data: data.income }, { name: 'Expense', data: data.expense }])
      })
  }

}
