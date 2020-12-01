require "rails_helper"

describe "As a visitor" do
  describe "When i visit the home page" do
    it "I see welcome text and a shor description of the site" do

      visit root_path

      expect(page).to have_content("Welcome To Viewing Party!")
      expect(page).to have_content("This website allows you to create a 'viewing party' with your friends to watch movies together online from the comfort of your own homes. Especially during these hard time during a pandemic when it isn't safe to be in the same room.")
    end

    it "I see a button to log in along with email and password form fields" do
      visit root_path

      expect(page).to have_field("email")
      expect(page).to have_field("password")
      expect(page).to have_button("Log In")
    end

    it "I see a link to register to viewing party" do
      visit root_path

      expect(page).to have_link("New to Viewing Party? Register Here")
    end
  end
end
