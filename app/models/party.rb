class Party < ApplicationRecord
  belongs_to :movie
  belongs_to :user
  has_many :guests
  has_many :users, through: :guests
  validates :date, presence: true
  validates :start_time, presence: true
  validates :duration, numericality: { greater_than: 0 }
end
