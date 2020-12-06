class Movie < ApplicationRecord

  validates_presence_of :title,
                        :duration,
                        :api_id
  validates :api_id, uniqueness: true
end
