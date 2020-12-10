require "rails_helper"

describe "Movie Facade" do
  it "returns a list of searched movies objects" do
    VCR.use_cassette('movies_by_search', :record => :new_episodes) do
      movies = MovieFacade.movies_by_search("Phoenix")

      expect(movies).to be_an(Array)
      expect(movies.size).to eq(20)
      expect(movies.first).to be_an_instance_of(MovieDetails)
    end
  end

  it "returns top movie objects" do
    VCR.use_cassette('top_movies', :record => :new_episodes) do
      movies = MovieFacade.top_40_movies

      expect(movies).to be_an(Array)
      expect(movies.size).to eq(40)
      expect(movies.first).to be_an_instance_of(MovieDetails)
    end
  end

  it "returns movie object" do
    VCR.use_cassette("movie_details2") do
      movie = MovieFacade.movie_data(278)

      expect(movie).to be_an_instance_of(MovieDetails)
    end
  end

  it "returns an actor object" do
    VCR.use_cassette('movie_details2') do
      actors = MovieFacade.cast_data(278)

      expect(actors).to be_an(Array)
      expect(actors.size).to eq(10)
      expect(actors.first).to be_an_instance_of(Actor)
    end
  end

  it "returns a review object" do
    VCR.use_cassette('movie_details2') do
      review = MovieFacade.review_data(278)

      expect(review).to be_an(Array)
      expect(review.count).to eq(6)
      expect(review.first).to be_an_instance_of(Review)
    end
  end

  it "returns a movie image object" do
    VCR.use_cassette('movie-details2') do
      image = MovieFacade.get_movie_image(278)

      expect(image.image).to be_a String
      expect(image).to be_an_instance_of(MovieImage)
    end
  end
end
