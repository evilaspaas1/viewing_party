require "rails_helper"

describe "as a user" do
  describe "from anywhere on the sight" do
    it "has a link to log out" do
      user = User.create!(name: "Tim", email: "tim@gmail.com", password: "test")
      visit root_path

      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_button "Log In"

      within "nav" do
        click_link "Log Out"
      end
      expect(current_path).to eq(root_path)
      expect(page).to have_content("You are now logged out")
      expect(page).to_not have_content("Log Out")
    end
  end
end
