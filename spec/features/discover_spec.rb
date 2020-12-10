require 'rails_helper'

describe 'as a registered user on the discover page' do
  before :each do
    VCR.use_cassette('trending_movies', :record => :new_episodes) do
      visit '/discover'
    end
  end

  it 'has a button to find top rated movies' do
    expect(page).to have_button("Find Top Rated Movies")
  end

  it 'when the button is clicked it takes us to the movies page' do
    VCR.use_cassette('trending_movies') do
      VCR.use_cassette('top_movies', :record => :new_episodes) do
        click_button("Find Top Rated Movies")
        expect(current_path).to eq("/movies")
      end
    end
  end

  it 'has a search field to search by movie title and button to initiate' do
    expect(page).to have_field(:search)
    expect(page).to have_button("Search By Title")
  end

  it 'when the button to find movies is clicked it takes us to the movies page' do
    VCR.use_cassette('trending_movies') do
      VCR.use_cassette('movies_by_search', :record => :new_episodes) do
        fill_in :search, with: "Phoenix"
        click_button("Search By Title")
        expect(current_path).to eq("/movies")
      end
    end
  end

  it 'returns an error if the field is not filled out' do
    fill_in :search, with: ""
    VCR.use_cassette('trending_movies') do
      click_button("Search By Title")
    end 
    expect(current_path).to eq("/discover")
    expect(page).to have_content("Must provide a search query")
  end

  it 'can search for movies in any case' do
    VCR.use_cassette('trending_movies') do
      VCR.use_cassette('case_sensitive_search', :record => :new_episodes) do
        fill_in :search, with: "pHoEnix"
        click_button("Search By Title")
        expect(current_path).to eq("/movies")
      end
    end
  end

  it 'can search for partial keyword/movie title' do
    VCR.use_cassette('trending_movies') do
      VCR.use_cassette('partial_results', :record => :new_episodes) do
        fill_in :search, with: "Pho"
        click_button("Search By Title")
        expect(current_path).to eq("/movies")
      end
    end
  end

  it 'has a list of trending movies' do



  end
end
