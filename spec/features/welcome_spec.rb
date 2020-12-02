require "rails_helper"

describe "As a visitor" do
  describe "When i visit the home page" do
    it "I see welcome text and a shor description of the site" do
      visit root_path

      expect(page).to have_content("Welcome To Viewing Party!")
      expect(page).to have_content("This website allows you to create a 'viewing party' with your friends to watch movies together online from the comfort of your own homes. Especially during these hard time during a pandemic when it isn't safe to be in the same room.")
    end

    it "I see a button to log in along with email and password form fields an when i log in succesfully im taken to my user dashboard" do
      user = User.create!(name: "Tim", email: "tim@gmail.com", password: "test")
      visit root_path

      expect(page).to have_field("email")
      expect(page).to have_field("password")

      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_button "Log In"

      expect(current_path).to eq("/dashboard")
    end

    it "I see a link to register to viewing party" do
      visit root_path

      expect(page).to have_link("New to Viewing Party? Register Here")
    end
    it "And fail to log in is see a flash message" do
      user = User.create!(name: "Tim", email: "tim@gmail.com", password: "test")
      visit root_path

      expect(page).to have_field("email")
      expect(page).to have_field("password")

      fill_in :email, with: "tim@live.com"
      fill_in :password, with: user.password

      click_button "Log In"

      expect(current_path).to eq("/")
      expect(page).to have_content("Your log in credentials are bad.")
    end
    it "And try to visit a user dashboard without logging in I see a 404 error" do
      visit dashboard_index_path

      expect(current_path).to eq(dashboard_index_path)
      expect(page).to have_content("The page you were looking for doesn't exist")
    end
  end
end
