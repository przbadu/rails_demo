class Wallet < ApplicationRecord
  # soft delete records
  acts_as_paranoid

  # monetize
  monetize :balance_cents

  # associations
  belongs_to :user

  # validations
  validates :name, presence: true
end
