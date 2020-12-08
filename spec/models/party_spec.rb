require 'rails_helper'

describe Party, type: :model do
  describe "validations" do
    it {should validate_presence_of(:date)}
    it {should validate_presence_of(:start_time)}
    it {should validate_numericality_of(:duration).is_greater_than(0)}
  end

  describe 'relationships' do
    it {should belong_to(:user)}
    it {should belong_to(:movie)}
    it {should have_many(:guests)}
  end
end
