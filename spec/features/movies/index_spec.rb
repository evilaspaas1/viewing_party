require 'rails_helper'

describe 'as a registered user on the movies index page' do
  before :each do
    @user = User.create!(name: "Tim", email: "tim@gmail.com", password: "test")
    visit root_path
    fill_in :email, with: @user.email
    fill_in :password, with: @user.password
    click_button "Log In"
    visit "/discover"
  end

  it 'only lists 40 results or less when we search by title' do
    VCR.use_cassette('movies_by_search') do
      fill_in :search, with: "Phoenix"
      click_button("Search By Title")
      expect(page).to have_css(".movie", :maximum => 40)
    end

    VCR.use_cassette('partial_results') do
      fill_in :search, with: "Pho"
      click_button("Search By Title")
      expect(page).to have_css(".movie", :maximum => 40)
    end
  end

  it 'each movie listed is a link to that movies show page' do
    VCR.use_cassette('top_movies') do
      click_button("Find Top Rated Movies")
      within(first(".movie")) do
        name = find('.title').text
        expect(name).not_to be_empty
      end
    end
  end

  it 'has a list of 40 of the top rated movies' do
    VCR.use_cassette('top_movies') do
      # top_20 = Faraday.get("https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['MOVIES_API_KEY']}&language=en-US&page=1")

      click_button("Find Top Rated Movies")
      expect(page).to have_css(".movie", count: 40)
      within(first(".movie")) do
        expect(page).to have_css(".title")
      end
    end
  end

  it 'the top rated movies have vote averages listed' do
    VCR.use_cassette('top_movies') do
      click_button("Find Top Rated Movies")
      within(first(".movie")) do
        expect(page).to have_css(".vote_average")
        average = find('.vote_average').text
        expect(average).not_to be_empty
      end
    end
  end
end
