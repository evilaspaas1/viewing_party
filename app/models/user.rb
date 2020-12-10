class User < ApplicationRecord
  has_secure_password
  validates :name,
            :email, presence: true
  validates :password, presence: { if: :password }
  validates :email, uniqueness: true

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :guests, dependent: :destroy
  has_many :parties, dependent: :destroy
end
