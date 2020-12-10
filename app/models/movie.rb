class Movie < ApplicationRecord
  validates :title,
            :duration,
            :api_id, presence: true
  validates :api_id, uniqueness: true
end
