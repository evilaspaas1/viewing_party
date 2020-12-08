require 'rails_helper'

describe Guest, type: :model do

  describe 'validations' do
    it {should validate_presence_of(:user_id)}
  end

  describe 'relationships' do
    it {should belong_to(:user)}
    it {should belong_to(:party)}
  end
end
