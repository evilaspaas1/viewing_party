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
      expect(page).to have_css("section.parties")
    end

    it "has a text field to enter a friend's email and a button to added that friend" do
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

    it "won't let me add friends I have already added" do
      fill_in :email, with: @shaunda.email
      click_button "Add Friend"

      fill_in :email, with: @shaunda.email
      click_button "Add Friend"
      expect(page).to have_content("You have already added this friend")
    end

    it "won't let me add myself as a friend" do
      fill_in :email, with: @user.email
      click_button "Add Friend"

      expect(page).to have_content("You can not add yourself as a friend")
    end

    it "can click on the Discover button and go to the discover page" do
      VCR.use_cassette('trending_movies') do
        click_button "Discover Movies"
      end
      expect(current_path).to eq("/discover")
    end

    it "can see the viewing parties I have been invited to including movie title, date/time of event, and invited status" do
      current_date = DateTime.now.to_date.to_s
      current_time = DateTime.now.to_time.to_s[11..15]
      harry_potter = Movie.create!({title: "Harry Potter and the Philosopher's Stone", duration: 152, api_id: 671})
      hp_watch_party = @user.parties.create!({movie_id: harry_potter.id, date: current_date, start_time: current_time, duration: 152 })
      guest = @user.guests.create!({party_id: hp_watch_party.id})
      visit dashboard_index_path

      within(".parties") do
        expect(page).to have_content(harry_potter.title)
        expect(page).to have_content(hp_watch_party.date)
        expect(page).to have_content(hp_watch_party.start_time)
        expect(page).to have_content("Hosting")
      end
    end

    it "can see the viewing parties I'm hosting including movie title, date/time of event, and hosting status" do
      current_date = DateTime.now.to_date.to_s
      current_time = DateTime.now.to_time.to_s[11..15]
      harry_potter = Movie.create!({title: "Harry Potter and the Philosopher's Stone", duration: 152, api_id: 671})
      hp_watch_party = Party.create!({user_id: @kiera.id, movie_id: harry_potter.id, date: current_date, start_time: current_time, duration: 152 })
      guest = @user.guests.create!({party_id: hp_watch_party.id})
      visit dashboard_index_path

      within("section.parties") do
        expect(page).to have_content(harry_potter.title)
        expect(page).to have_content(hp_watch_party.date)
        expect(page).to have_content(hp_watch_party.start_time)
        expect(page).to have_content("Invited")
      end
    end
  end
end
