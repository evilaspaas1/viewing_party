class User < ApplicationRecord
  has_secure_password
  validates_presence_of :name,
                        :email
  validates_presence_of :password, if: :password
  # validates :password, confirmation: true, presence: true
  validates :email, uniqueness: true
end
