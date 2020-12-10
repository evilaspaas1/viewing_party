require "rails_helper"

describe "As a registered user" do
  describe "when I create a new viewing party" do

    before :each do
      @user = User.create!(name: "Tim", email: "tim@gmail.com", password: "test")
      @shaunda = @user.friends.create!(name: "Shaunda", email: "shaunda@gmail.com", password: "test")
      @austin = @user.friends.create!(name: "Austin", email: "austin@gmail.com", password: "test")
      @kiera = @user.friends.create!(name: "Kiera", email: "kiera@gmail.com", password: "test")
      visit root_path
      fill_in :email, with: @user.email
      fill_in :password, with: @user.password
      click_button "Log In"
      VCR.use_cassette("movie_details2") do
        visit "/movies/278"
      end
      click_button "Create Viewing Party"
    end

    it "has a form with the movie title which i can't change" do
      within ".movie_title" do
        expect(page).to have_content("The Shawshank Redemption")
      end

      within ".party_form" do
        expect(page).to have_field(:duration)
        expect(page).to have_field(:date)
        expect(page).to have_field(:start_time)
        expect(page).to have_button("Create Viewing Party")
      end
      expect(current_path).to eq(new_party_path)
    end

    it "has a duration field that is pre-populated with the movie duration" do
      movie = Movie.last
      within ".party_form" do
        expect(page).to have_field(:duration, with: movie.duration)
      end
    end

    it "can choose friend(s) to attend by checking boxes" do
      within ".party_form" do
        check "#{@shaunda.name}"
        check "#{@kiera.name}"
      end
    end

    it "enter start time and date" do
      within ".party_form" do
        fill_in :date, with: "2020-08-12"
        fill_in :start_time, with: "7:00"
      end
    end

    it "I can see the new party on my dashboard page" do
      movie = Movie.last
      within ".party_form" do
        fill_in :duration, with: movie.duration
        fill_in :date, with: "12-08-2020"
        fill_in :start_time, with: "7:00"
        check "#{@shaunda.name}"
        check "#{@kiera.name}"
        click_button "Create Viewing Party"
      end
      expect(current_path).to eq(dashboard_index_path)
      expect(page).to have_content("2020-08-12 2000-01-01 07:00:00 UTC")
    end

    it "I can create a party without guests" do
      movie = Movie.last
      within ".party_form" do
        fill_in :duration, with: movie.duration
        fill_in :date, with: "12-08-2020"
        fill_in :start_time, with: "7:00"
        click_button "Create Viewing Party"
      end
    end

    it "text" do
      movie = Movie.last
      within ".party_form" do
        fill_in :duration, with: ""
        fill_in :date, with: ""
        fill_in :start_time, with: ""
        check "#{@shaunda.name}"
        check "#{@kiera.name}"
        click_button "Create Viewing Party"
      end
      expect(page).to have_content("Date can't be blank, Start time can't be blank, and Duration is not a number")
    end
  end
end
