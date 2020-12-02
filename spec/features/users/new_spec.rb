require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'When I click the Register link on the Welcome Page' do
    it "I am taken to the registration page where there is a form to register" do
      visit root_path

      click_link "New to Viewing Party? Register Here"

      expect(current_path).to eq('/register')
      expect(page).to have_content("Email")
      expect(page).to have_content("Password")
      expect(page).to have_content("Confirm Password")
      expect(page).to have_button("Register")
      expect(page).to have_link("Already Registered? Log in Here")
    end
  end
end

# TESTING CO-AUTHORED COMMITS
# TESTING CO-AUTHORED COMMITS AGAIN
