require "rails_helper"

describe "as a visitor" do
  describe "when i visit the home page" do
    it "I see welcome text and a shor description of the site" do

      visit root_path

      expect(page).to have_content("Welcome To Viewing Party!")
      expect(page).to have_content("This website allows you to create a 'viewing party' with your friends to watch movies together online from the comfort of your own homes. Especially during these hard time during a pandemic when it isn't safe to be in the same room.")
    end

    it "text" do

    end
  end
end
