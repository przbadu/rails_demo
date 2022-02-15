class Wallet < ApplicationRecord
  # soft delete records
  acts_as_paranoid

  # audit log
  audited only: %i[name color icon balance_cents deleted_at],
          on: %i[create update]

  # monetize
  monetize :balance_cents

  # associations
  belongs_to :user

  # validations
  validates :name, presence: true

  # sum total balance and return money object
  def self.total_cents
    Money.from_cents sum(:balance_cents)
  end
end
