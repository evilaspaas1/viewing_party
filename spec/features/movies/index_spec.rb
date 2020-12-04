require 'rails_helper'

describe 'as a user on the movies index page' do
  it 'I have to be a logged in user to view the movies page' do
    visit '/movies'

    expect(current_path).to eq(dashboard_index_path)
    expect(page).to have_content("The page you were looking for doesn't exist")
  end

  before :each do
    @user = User.create!(name: "Tim", email: "tim@gmail.com", password: "test")
    visit root_path
    fill_in :email, with: @user.email
    fill_in :password, with: @user.password
    click_button "Log In"
    visit "/discover"
  end

  it 'has a button to find top rated movies' do
    expect(page).to have_button("Find Top Rated Movies")
  end

  it 'when the button is clicked it takes us to the movies page' do
    click_button("Find Top Rated Movies")
    expect(current_path).to eq("/movies")
  end

  it 'has a search field to search by movie title and button to initiate' do
    expect(page).to have_field(:search)
    expect(page).to have_button("Search By Title")
  end

  it 'when the button to find movies is clicked it takes us to the movies page' do
    fill_in :search, with: "Titanic"
    click_button("Search By Title")
    expect(current_path).to eq("/movies")
  end

  it 'has a list of 40 of the top rated movies' do
    VCR.use_cassette('test5') do
      response = Faraday.get("https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['MOVIES_API_KEY']}&language=en-US&total_pages=2")
      json = JSON.parse(response.body, symbolize_names: true)

      click_button("Find Top Rated Movies")
      expect(page).to have_css(".movie", count: 40)
      within(first(".movie")) do
        expect(page).to have_css(".title")
      end
    end
  end

  it 'only lists 40 results or less when we search by title' do
    VCR.use_cassette('40_by_title') do
      fill_in :search, with: "Phoenix"
      click_button("Search By Title")
      expect(page).to have_css(".movie", :maximum => 40)

      fill_in :search, with: "Pho"
      click_button("Search By Title")
      expect(page).to have_css(".movie", :maximum => 40)
    end
  end

  it 'the top rated movies have vote averages listed' do
    VCR.use_cassette('top_40_movies') do
      click_button("Find Top Rated Movies")
      within(first(".movie")) do
        expect(page).to have_css(".average_rating")
      end
    end
  end

  it 'each movie listed is a link to that movies show page' do
    VCR.use_cassette('top_40_movies') do
      click_button("Find Top Rated Movies")
      within(first(".movie")) do
        first_movie = page.all('.movie')[0]
        expect(page).to have_link(first_movie.title)
      end
    end
  end
end
