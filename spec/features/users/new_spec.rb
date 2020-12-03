require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'When I click the Register link on the Welcome Page' do
    before :each do
      User.create!(name: "Tim", email: "tim@gmail.com", password: "test")

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
      fill_in :password_confirmation, with: "password"

      click_button "Register"

      user = User.last

      expect(user.name).to eq("Brian")
      expect(current_path).to eq(dashboard_index_path)
      expect(page).to have_content("You are now registered and logged in.")
      expect(page).to have_content("Welcome, Brian")
    end

    it "doesn't create a new user if email isn't unique" do

      fill_in :name, with: "Tim"
      fill_in :email, with: "tim@gmail.com"
      fill_in :password, with: "password"
      fill_in :password_confirmation, with: "password"

      click_button "Register"

      expect(page).to have_content("Email has already been taken")
      expect(current_path).to eq("/register")
    end

    it "doesn't create a new user if passwords don't match" do

      fill_in :name, with: "Brian"
      fill_in :email, with: "brian@gmail.com"
      fill_in :password, with: "password"
      fill_in :password_confirmation, with: "blastword"

      click_button "Register"
save_and_open_page
      expect(page).to have_content("Password confirmation doesn't match Password")
      expect(current_path).to eq("/register")
    end
  end
end
