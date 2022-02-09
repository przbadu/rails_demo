class Category < ApplicationRecord
  acts_as_paranoid

  # associations
  belongs_to :user

  # validations
  validates :name, presence: true
end
