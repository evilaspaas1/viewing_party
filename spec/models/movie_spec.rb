require "rails_helper"

describe Movie, type: :model do
  describe "validations" do
    it {should validate_presence_of(:title)}
    it {should validate_presence_of(:duration)}
    it {should validate_uniqueness_of(:api_id)}
  end
end
