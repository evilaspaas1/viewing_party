class User < ApplicationRecord
  has_secure_password
  validates :name,
            :email, presence: true
  validates :password, presence: { if: :password }
  validates :email, uniqueness: true

  has_many :friendships
  has_many :friends, through: :friendships
  has_many :guests
  has_many :parties
end
