class Category < ApplicationRecord
  # soft delete
  acts_as_paranoid

  # audit log
  audited only: %i[name color icon deleted_at],
          on: %i[create update]

  # associations
  belongs_to :user

  # validations
  validates :name, presence: true
end
