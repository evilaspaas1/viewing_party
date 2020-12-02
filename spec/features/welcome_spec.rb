require "rails_helper"

describe "as a visitor" do
  describe "when i visit the home page" do
    it "I see welcome text" do
      visit root_path
      expect(page).to have_content("Welcome")
    end
  end
end
