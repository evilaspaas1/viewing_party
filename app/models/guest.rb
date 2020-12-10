class Guest < ApplicationRecord
  belongs_to :user
  belongs_to :party

  validates :user_id, presence: true
end
