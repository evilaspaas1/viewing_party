class Party < ApplicationRecord
  belongs_to :movie
  belongs_to :user
  has_many :guests
  has_many :users, through: :guests
  validates_presence_of :date
  validates_presence_of :start_time
  validates :duration, numericality: { greater_than: 0 }
end
