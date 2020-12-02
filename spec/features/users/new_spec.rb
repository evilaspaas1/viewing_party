require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'When I click the Register link on the Welcome Page' do
    before :each do
      visit root_path

      click_link "New to Viewing Party? Register Here"
    end

    it "I am taken to the registration page where there is a form to register" do
      expect(current_path).to eq('/register')
      expect(page).to have_content("Email")
      expect(page).to have_content("Password")
      expect(page).to have_content("Confirm Password")
      expect(page).to have_button("Register")
      expect(page).to have_link("Already Registered? Log in Here")
    end

    it "creates a new user who should be then logged in and redirected to dashboard page" do

      fill_in :name, with: "Brian"
      fill_in :email, with: "brian@gmail.com"
      fill_in :password, with: "password"
      fill_in :confirm_password, with: "password"

      click_button "Register"

      expect(current_path).to eq(dashboard_index_path)
      expect(page).to have_content("Welcome, Brian")
    end
  end
end
