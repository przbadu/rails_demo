class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # associations
  has_many :categories
  has_many :wallets
  has_many :transactions

  def username
    email.split('@').first.to_s.humanize
  end
end
