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

  def format_audit_log(audit)
    case audit.action
    when 'create'
      create_log(audit)
    when 'update'
      update_log(audit)
    end
  end

  def create_log(audit)
    if audit.auditable_type == 'Transaction'
      "Created Transaction: #{audit.audited_changes['notes']} - #{audit.audited_changes['amount_cents']}"
    elsif audit.auditable_type == 'Wallet' || audit.auditable_type == 'Category'
      "Created #{audit.auditable_type}: #{audit.audited_changes['name']}"
    else
      "Created #{audit.auditable_type}"
    end
  end

  def update_log(audit)
    str = "#{audit.auditable_type} updated:"

    audit.audited_changes.each_key do |key|
      str += " #{key} from #{audit.audited_changes[key].first} to #{audit.audited_changes[key].last}"
    end
    str
  end
end
