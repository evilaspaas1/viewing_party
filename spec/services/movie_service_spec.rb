require 'rails_helper'
describe MovieService do
  context "instance methods" do
    context "#movies_by_search" do
      it "returns movies by search term" do
        VCR.use_cassette("movies_by_search") do
          @search = MovieService.movies_by_search("Phoenix")
        end
        expect(@search).to be_a Hash
        expect(@search[:results]).to be_an Array
        expect(@search.count).to be_between(1, 40)
        movie = @search[:results].first
        expect(movie).to have_key :title
        expect(movie[:title]).to be_a(String)
        expect(movie).to have_key :id
        expect(movie[:id]).to be_a(Integer)
        expect(movie).to have_key :vote_average
        expect(movie[:vote_average]).to be_a(Float)
        expect(movie).to have_key :overview
        expect(movie[:overview]).to be_a(String)
      end
    end
    context "#top_40_movies" do
      it "returns top 40 movies" do
        VCR.use_cassette("top_movies") do
          @search = MovieService.top_40_movies
        end
        expect(@search).to be_an Array
        expect(@search.count).to be_between(1, 40)
        movie = @search.first
        expect(movie).to have_key :title
        expect(movie[:title]).to be_a(String)
        expect(movie).to have_key :id
        expect(movie[:id]).to be_a(Integer)
        expect(movie).to have_key :vote_average
        expect(movie[:vote_average]).to be_a(Float)
        expect(movie).to have_key :overview
        expect(movie[:overview]).to be_a(String)
      end
    end
    context "#movie_data" do
      it "returns data specific to a single movie" do
        VCR.use_cassette("movie_details2") do
          @search = MovieService.movie_data(278)
        end

        expect(@search).to be_a Hash

        movie = @search
        expect(movie).to have_key :title
        expect(movie[:title]).to be_a(String)

        expect(movie).to have_key :id
        expect(movie[:id]).to be_a(Integer)

        expect(movie).to have_key :vote_average
        expect(movie[:vote_average]).to be_a(Float)

        expect(movie).to have_key :overview
        expect(movie[:overview]).to be_a(String)
      end
    end
    context "#cast_data" do
      it "returns all cast members for a movie" do
        VCR.use_cassette("movie_details2") do
          @search = MovieService.cast_data(278)
        end

        expect(@search).to be_an Array

        actor = @search.first
        expect(actor).to have_key :name
        expect(actor[:name]).to be_a(String)
      end
    end
    context "#review_data" do
      it "returns all reviews for a movie" do
        VCR.use_cassette("movie_details2") do
          @search = MovieService.review_data(278)
        end

        expect(@search).to be_an Hash
        review = @search[:results].first
        expect(review[:author_details]).to have_key :username
        expect(review[:author_details][:username]).to be_a(String)
        expect(review).to have_key :content
        expect(review[:content]).to be_a(String)
      end
    end

    context "#get_movie_image" do
      it "returns images for a movie" do
        VCR.use_cassette("movie_details2") do
          @search = MovieService.get_movie_image(278)
        end

        expect(@search).to be_a Hash
        image = @search[:file_path]
        expect(image).to be_a(String)
      end
    end

    context "#trending_movies" do
      it "returns the trending movies for the week" do
        VCR.use_cassette('trending_movies') do
          @search = MovieService.trending_movies
        end

        expect(@search).to be_an Array
        movie = @search.first
        expect(movie).to have_key :title
        expect(movie[:title]).to be_a(String)
        expect(movie).to have_key :vote_average
        expect(movie[:vote_average]).to be_a(Float)
      end
    end
  end
end
