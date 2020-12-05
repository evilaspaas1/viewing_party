require 'rails_helper'

describe 'As a registered user' do
  describe 'when I am on my dashboard' do
    before :each do
      @user = User.create!(name: "Tim", email: "tim@gmail.com", password: "test")
      visit root_path
      fill_in :email, with: @user.email
      fill_in :password, with: @user.password
      click_button "Log In"
    end

    it "can see a welcome message with my username" do
      within(".header") do
        expect(page).to have_content("Welcome, #{@user.name}!")
      end
    end

    it "has a section to display all my friends" do
      expect(page).to have_css("section.friends")
    end

    it "has a button to Discover Movies" do
      expect(page).to have_button("Discover Movies")
    end

    it "has a viewing parties section" do
      expect(page).to have_css("section.viewing_parties")
    end
  end
end
