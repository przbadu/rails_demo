class DashboardsController < ApplicationController
  before_action :set_filters

  def index
    set_income_amount
    set_expense_amount
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

  private

  def set_income_amount
    @income_amount = current_user.transactions.income_type.filter_by_date(@from, @to).load_async.total_cents
  end

  def set_expense_amount
    @expense_amount = current_user.transactions.expense_type.filter_by_date(@from, @to).load_async.total_cents
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
    return 'This Month' unless filter_params[:filter_date]
    return 'Today' if filter_params[:filter_date].downcase == 'today'

    "This #{filter_params[:filter_date]}"
  end

  def filter_params
    params.permit(:filter_date)
  end
end
