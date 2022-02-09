class Transaction < ApplicationRecord
  # soft delete records
  acts_as_paranoid

  # monetize
  monetize :amount

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
end
