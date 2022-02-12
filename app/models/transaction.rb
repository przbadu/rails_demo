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

  # sum total amount and return money object
  def self.total_cents
    Money.from_cents sum(:amount_cents)
  end
end
