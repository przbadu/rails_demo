class DashboardsController < ApplicationController
  before_action :set_filters

  def index
    set_date_filter_text
    set_income_amount
    set_expense_amount
    set_balance_amount
    set_income_line_chart_data
    set_expense_line_chart_data
    set_expense_category_data
    @audits = Audited::Audit.first(5)
  end

  def income_amount
    set_income_amount
    render json: {
      amount: helpers.amount_to_currency(@income_amount),
      filter_text: set_date_filter_text
    }
  end

  def expense_amount
    set_expense_amount

    render json: {
      amount: helpers.amount_to_currency(@expense_amount),
      filter_text: set_date_filter_text
    }
  end

  def cashflow_data
    set_income_line_chart_data
    set_expense_line_chart_data

    render json: {
      income: @income_line_chart_data,
      expense: @expense_line_chart_data,
      filter_text: set_date_filter_text
    }
  end

  def expense_category_data
    set_expense_category_data

    render json: {
      filter_text: set_date_filter_text,
      data: @expense_categories
    }
  end

  private

  def set_income_amount
    @income_amount = current_user.transactions
                                 .income_type
                                 .filter_by_date(@from, @to)
                                 .load_async.total_cents
  end

  def set_expense_amount
    @expense_amount = current_user.transactions
                                  .expense_type
                                  .filter_by_date(@from, @to)
                                  .load_async.total_cents
  end

  def set_balance_amount
    @balance_amount = current_user.wallets.total_cents
  end

  def set_income_line_chart_data
    @income_line_chart_data = current_user.transactions.income_type.filter_by_date(@from, @to).load_async
    @income_line_chart_data = case filter_params[:filter_date].to_s.downcase
                              when 'today'
                                @income_line_chart_data.group_by_hour(:transaction_at).sum(:amount_cents)
                              when 'year'
                                @income_line_chart_data.group_by_month(:transaction_at).sum(:amount_cents)
                              else
                                @income_line_chart_data.group_by_day(:transaction_at).sum(:amount_cents)
                              end
    @income_line_chart_data = prepare_chart_data(@income_line_chart_data)
  end

  def set_expense_line_chart_data
    @expense_line_chart_data = current_user.transactions.expense_type.filter_by_date(@from, @to).load_async
    @expense_line_chart_data = case filter_params[:filter_date].to_s.downcase
                               when 'today'
                                 @expense_line_chart_data.group_by_hour(:transaction_at).sum(:amount_cents)
                               when 'year'
                                 @expense_line_chart_data.group_by_month(:transaction_at).sum(:amount_cents)
                               else
                                 @expense_line_chart_data.group_by_day(:transaction_at).sum(:amount_cents)
                               end
    @expense_line_chart_data = prepare_chart_data(@expense_line_chart_data)
  end

  def set_expense_category_data
    @expense_categories = current_user.transactions
                                      .joins(:category)
                                      .group('categories.id')
                                      .where('transactions.transaction_type': Transaction.transaction_types[:expense])
                                      .where('transactions.transaction_at': @from..@to)
                                      .order('sum(transactions.amount_cents) desc')
                                      .limit(5)
                                      .pluck('categories.name', 'categories.color', 'sum(transactions.amount_cents)')
  end

  def set_filters
    @from = case filter_params[:filter_date].to_s.downcase
            when 'today'
              Time.current.beginning_of_day
            when 'year'
              Time.current.beginning_of_year
            else
              Time.current.beginning_of_month
            end
    @to = Time.current.end_of_day
  end

  def set_date_filter_text
    @date_filter_text = 'This Month'
    if filter_params[:filter_date].to_s.downcase == 'today'
      @date_filter_text = 'Today'
    elsif filter_params[:filter_date].present?
      @date_filter_text = "This #{filter_params[:filter_date]}"
    end
    @date_filter_text
  end

  def filter_params
    params.permit(:filter_date)
  end

  def to_date_s(datetime)
    return datetime if datetime.blank?

    datetime.strftime('%Y-%m-%d')
  end

  def to_time_s(datetime)
    return datetime if datetime.blank?

    datetime.strftime('%H:%M')
  end

  def prepare_chart_data(data)
    @data = data.map do |d|
      [
        # params[:filter] == 'today' ? to_time_s(d.first) : to_date_s(d.first),
        d.first,
        Money.from_cents(d.last).to_f
      ]
    end
  end
end
