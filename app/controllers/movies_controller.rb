class MoviesController < ApplicationController
  def index
    if params[:search] == ""
      flash[:error] = "Must provide a search query"
      redirect_to "/discover"
    elsif params[:search]
      # search_term = params[:search]
      # require "pry"; binding.pry
      movies_by_search = Faraday.get("https://api.themoviedb.org/3/search/movie?api_key=#{ENV['MOVIES_API_KEY']}&query=#{params[:search]}")
      json = JSON.parse(movies_by_search.body, symbolize_names: :true)
      @movies = json[:results]
      # require "pry"; binding.pry
    else
      top_20 = Faraday.get("https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['MOVIES_API_KEY']}&language=en-US&page=1")
      second_20 = Faraday.get("https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['MOVIES_API_KEY']}&language=en-US&page=2")
      parsed_top_20 = JSON.parse(top_20.body, symbolize_names: :true)
      parsed_second_20 = JSON.parse(second_20.body, symbolize_names: :true)
      @movies = (parsed_top_20[:results] << parsed_second_20[:results]).flatten
      # require "pry"; binding.pry
    end
  end
end
