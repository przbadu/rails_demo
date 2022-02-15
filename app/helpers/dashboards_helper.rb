module DashboardsHelper
  def cashflow_line_chart_series
    [
      { name: 'Income', data: @income_line_chart_data },
      { name: 'Expense', data: @expense_line_chart_data }
    ]
  end

  def cashflow_line_chart_options
    {
      title: 'Cash Flow',
      subtitle: "Grouped by #{@date_filter_text}",
      xtitle: @date_filter_text.to_s.downcase.sub('this ', '').titlecase,
      ytitle: 'Amount',
      stacked: true
    }
  end

  def pie_chart_data(data)
    data.map { |d| [d.first, d.last] }
  end
end
