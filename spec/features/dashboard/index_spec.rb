require 'rails_helper'

describe 'As a registered user' do
  describe 'when I am on my dashboard' do
    before :each do
      @user = User.create!(name: "Tim", email: "tim@gmail.com", password: "test")
      @shaunda = User.create!(name: "Shaunda", email: "shaunda@gmail.com", password: "test")
      @austin = User.create!(name: "Austin", email: "austin@gmail.com", password: "test")
      @kiera = User.create!(name: "Kiera", email: "kiera@gmail.com", password: "test")

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

    it "has a text field to enter a friend's email and a button to addasd that friend" do
      within("section.friends") do
        expect(page).to have_field(:email)
        expect(page).to have_button("Add Friend")
      end
    end

    it "shows a 'You Currently Have No Friends' message if I haven't added any friends" do
      within("section.friends") do
        expect(page).to have_content("You Currently Have No Friends")
      end
    end

    it "I can add a friend using their email as long as they exist in database" do

      within("section.friends") do
        fill_in :email, with: @shaunda.email
        click_button "Add Friend"
        expect(current_path).to eq("/dashboard")

        fill_in :email, with: "today@gmail.com"
        click_button "Add Friend"

        expect(current_path).to eq("/dashboard")
      end
      expect(page).to have_content("I'm sorry your friend cannot be found")
    end

    it "shows a list of all my friends that I have added" do
      fill_in :email, with: @shaunda.email
      click_button "Add Friend"

      fill_in :email, with: @austin.email
      click_button "Add Friend"

      fill_in :email, with: @kiera.email
      click_button "Add Friend"

      within("section.friends") do
        expect(page).to have_content(@shaunda.name)
        expect(page).to have_content(@austin.name)
        expect(page).to have_content(@kiera.name)
      end
    end

    it "can click on the Discover button and go to the discover page" do
      click_button "Discover Movies"
      expect(current_path).to eq("/discover")
    end
  end
end
