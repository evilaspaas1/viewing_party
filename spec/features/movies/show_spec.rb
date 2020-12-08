require "rails_helper"

describe "As A registered user when I visit a movies show page" do
  before :each do
    @user = User.create!(name: "Tim", email: "tim@gmail.com", password: "test")
    visit root_path
    fill_in :email, with: @user.email
    fill_in :password, with: @user.password
    click_button "Log In"
    visit "/discover"
  end

  it "I am taken to the movies show page when i click on a movie title" do
    VCR.use_cassette('top_movies') do
      click_button("Find Top Rated Movies")
      VCR.use_cassette('movie_details2') do
        click_link "The Shawshank Redemption"
        expect(current_path).to eq("/movies/278")
      end
    end
  end
end

describe "As a user on the movies show page" do
  before :each do
    VCR.use_cassette('movie_details2') do
      visit "/movies/278"
    end
  end

  it "I see a button to create a viewing party and when I click that button I'm taken to a viewing party page" do
    click_button("Create Viewing Party")

    expect(current_path).to eq("/party/new")
  end

  it "I see information about this movie" do

    expect(page).to have_content("The Shawshank Redemption")

    within ".movie_details" do
      expect(page).to have_content("8.7")
      expect(page).to have_content("142")
      expect(page).to have_content("Drama")
      expect(page).to have_content("Crime")
    end

    within ".movie_summary" do
      expect(page).to have_content("Framed in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.")
    end

    within(first(".cast")) do
      expect(page).to have_content("Tim Robbins")
    end


    expect(page).to have_css("#actor", :maximum => 10)


    within ".review_count" do
      expect(page).to have_content("6")
    end

    within (first(".review_details")) do
      expect(page).to have_content("Author: elshaarawy")
      expect(page).to have_content("very good movie 9.5/10")
    end
  end
end
