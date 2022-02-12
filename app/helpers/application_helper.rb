module ApplicationHelper
  include Pagy::Frontend

  def amount_to_currency(amount)
    return amount if amount.blank?

    number_to_currency(amount, unit: "#{amount.currency.symbol} ")
  end

  def amount_colorize(type)
    return type unless type

    type.to_s == 'income' ? 'text-success' : 'text-danger'
  end

  def format_date(date)
    return date unless date

    date.strftime('%b %d, %Y %H:%M %P')
  end

  def generate_random_colors(count: 10)
    colors = []
    count.times { colors << format('%06x', (rand * 0xffffff)) }
    colors
  end
end
