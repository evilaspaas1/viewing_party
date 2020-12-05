class MoviesController < ApplicationController
  def index
    if params[:search] == ""
      flash[:error] = "Must provide a search query"
      redirect_to "/discover"
    elsif params[:search]
      movies_by_search = Faraday.get("https://api.themoviedb.org/3/search/movie?api_key=#{ENV['MOVIES_API_KEY']}&query=#{params[:search]}")
      json = JSON.parse(movies_by_search.body, symbolize_names: :true)
      @movies = json[:results]
    else
      top_20 = Faraday.get("https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['MOVIES_API_KEY']}&language=en-US&page=1")
      second_20 = Faraday.get("https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['MOVIES_API_KEY']}&language=en-US&page=2")
      parsed_top_20 = JSON.parse(top_20.body, symbolize_names: :true)
      parsed_second_20 = JSON.parse(second_20.body, symbolize_names: :true)
      @movies = (parsed_top_20[:results] << parsed_second_20[:results]).flatten
    end
  end

  def show
    movie_details = Faraday.get("https://api.themoviedb.org/3/movie/#{params[:id]}?api_key=#{ENV['MOVIES_API_KEY']}")
    @movie = JSON.parse(movie_details.body, symbolize_names: :true)

    cast_data = Faraday.get("https://api.themoviedb.org/3/movie/#{params[:id]}/credits?api_key=#{ENV['MOVIES_API_KEY']}")
    cast_json = JSON.parse(cast_data.body, symbolize_names: :true)
    @cast = cast_json[:cast].first(10)

    review_data = Faraday.get("https://api.themoviedb.org/3/movie/#{params[:id]}/reviews?api_key=#{ENV['MOVIES_API_KEY']}")
    review_json = JSON.parse(review_data.body, symbolize_names: :true)
    @total_results = review_json[:total_results]
    @reviews = review_json[:results]
  end
end
