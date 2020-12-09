class MoviesController < ApplicationController
  def index
    search_term = params[:search]
    if search_term == ""
      flash[:error] = "Must provide a search query"
      redirect_to "/discover"
    elsif search_term
      @movies = MovieFacade.movies_by_search(search_term)
    else
      @movies = MovieFacade.top_40_movies
    end
  end

  def show
    movie_id = params[:id]
    @movie = MovieFacade.movie_data(movie_id)

    cast_data = Faraday.get("https://api.themoviedb.org/3/movie/#{params[:id]}/credits?api_key=#{ENV['MOVIES_API_KEY']}")
    cast_json = JSON.parse(cast_data.body, symbolize_names: :true)
    @cast = cast_json[:cast].first(10) #refactor to .take(10)?

    review_data = Faraday.get("https://api.themoviedb.org/3/movie/#{params[:id]}/reviews?api_key=#{ENV['MOVIES_API_KEY']}")
    review_json = JSON.parse(review_data.body, symbolize_names: :true)
    @total_results = review_json[:total_results]
    @reviews = review_json[:results]
  end
end
