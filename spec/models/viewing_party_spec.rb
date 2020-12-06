require 'rails_helper'

describe ViewingParty, type: :model do
  describe "validations" do
    it {should validate_presence_of(:date}
    it {should validate_presence_of(:start_time)}
    it {should validate_presence_of(:duration)}
    it {should validate_presence_of(:duration)}
  end

  describe 'relationships' do
    it {should have_many :movies}
    it {should belong_to :user}
  end
end
