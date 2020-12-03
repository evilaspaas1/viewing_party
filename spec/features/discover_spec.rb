require 'rails_helper'

describe 'as a user on the discover page' do
  before :each do
    visit '/discover'
  end

  it 'has a button to find top rated movies' do
    expect(page).to have_button("Find Top Rated Movies")
  end

  it 'when the button is clicked it takes us to the movies page' do
    click_button("Find Top Rated Movies")
    expect(current_path).to eq("/movies")
  end

  it 'has a search field to search by movie title and button to initiate' do
    expect(page).to have_field(:search_by_title)
    expect(page).to have_button("Find Movies")
  end

  it 'when the button to find movies is clicked it takes us to the movies page' do
    fill_in(:search_by_title).with("Titanic")
    click_button("Find Movies")
    expect(current_path).to eq("/movies")
  end

  it 'returns an error if the field is not filled out' do
    fill_in(:search_by_title).with("")
    click_button("Find Movies")
    expect(current_path).to eq("/discover")
    expect(page).to have_content("Must provide a search query")
  end

  it 'can search for movies in any case' do
    fill_in(:search_by_title).with("tiTanIc")
    click_button("Find Movies")
    expect(current_path).to eq("/movies")
  end

  it 'can search for partial keyword/movie title' do
    fill_in(:search_by_title).with("phoe")
    click_button("Find Movies")
    expect(current_path).to eq("/movies")
  end
end
