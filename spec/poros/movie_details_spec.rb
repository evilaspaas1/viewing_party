require "rails_helper"

describe "Movie Details Poro" do
  it "has attributes" do
    movie_data = {
    "genres": [
        {
            "id": 35,
            "name": "Comedy"
        },
        {
            "id": 18,
            "name": "Drama"
        },
        {
            "id": 10749,
            "name": "Romance"
        }
    ],
    "id": 13,
    "overview": "A man with a low IQ has accomplished great things in his life and been present during significant historic events—in each case, far exceeding what anyone imagined he could do. But despite all he has achieved, his one true love eludes him.",
    "runtime": 142,
    "title": "Forrest Gump",
    "vote_average": 8.5,
}

    movie = MovieDetails.new(movie_data)

    expect(movie.id).to eq(movie_data[:id])
    expect(movie.title).to eq(movie_data[:title])
    expect(movie.vote_average).to eq(movie_data[:vote_average])
    expect(movie.runtime).to eq(movie_data[:runtime])
    expect(movie.overview).to eq(movie_data[:overview])
    expect(movie.genres.count).to eq(3)
  end
end
