import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="budget-filter"
export default class extends Controller {
  static targets = ['label', 'chart']

  filter(event) {
    event.preventDefault()
    const params = event.params
    const chartId = this.element.dataset.chartId
    const chart = Chartkick.charts[chartId]

    fetch(params.url)
      .then(response => response.json())
      .then(({ data, filter_text }) => {
        const colors = data.map(d => `#${d[1]}`)
        const chartData = data.map(d => [d[0], d[2]])

        this.labelTarget.innerText = filter_text
        chart.updateData(chartData)
        chart.setOptions({ colors })
      })
      .catch(e => console.error(e))
  }
}
