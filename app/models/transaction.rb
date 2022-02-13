class Transaction < ApplicationRecord
  # soft delete records
  acts_as_paranoid

  # monetize
  monetize :amount_cents

  # enum
  enum :transaction_type, %i[income expense], default: :expense, suffix: :type

  # associations
  belongs_to :wallet
  belongs_to :category
  belongs_to :user

  # validations
  validates :transaction_at, presence: true
  validates :notes, presence: true
  validates :amount, presence: true
  validates :transaction_type, presence: true

  # scopes
  scope :filter_by_date, ->(from, to = Time.current) { where(transaction_at: from..to) }
  # NOTE: use below filters with filter_by_date, default filter is by all dates
  scope :group_by_hour, ->(column_name = :transaction_at) { group("DATE_TRUNC('hour', #{column_name})") }
  scope :group_by_day, ->(column_name = :transaction_at) { group("DATE_TRUNC('day', #{column_name})") }
  scope :group_by_week, ->(column_name = :transaction_at) { group("DATE_TRUNC('week', #{column_name})") }
  scope :group_by_month, ->(column_name = :transaction_at) { group("DATE_TRUNC('month', #{column_name})") }
  scope :group_by_year, ->(column_name = :transaction_at) { group("DATE_TRUNC('year', #{column_name})") }

  # sum total amount and return money object
  def self.total_cents
    Money.from_cents sum(:amount_cents)
  end
end
