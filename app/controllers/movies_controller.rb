class MoviesController < ApplicationController
  def index # Metrics/MethodLength: Method has too many lines. [14/10]
    if params[:search] == ''
      flash[:error] = 'Must provide a search query'
      redirect_to '/discover'
    elsif params[:search]
      movies_by_search = Faraday.get("https://api.themoviedb.org/3/search/movie?api_key=#{ENV['MOVIES_API_KEY']}&query=#{params[:search]}") # Layout/LineLength: Line is too long. [139/120]
      json = JSON.parse(movies_by_search.body, symbolize_names: :true) #Lint/BooleanSymbol: Symbol with a boolean name - you probably meant to use true.
      @movies = json[:results]
    else
      top_20 = Faraday.get("https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['MOVIES_API_KEY']}&language=en-US&page=1") # Naming/VariableNumber: Use normalcase for variable numbers: #{ENV['MO
        #Layout/LineLength: Line is too long. [129/120]
      second_20 = Faraday.get("https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['MOVIES_API_KEY']}&language=en-US&page=2") # Naming/VariableNumber: Use normalcase for variable numbers: #{ENV['MO
      parsed_top_20 = JSON.parse(top_20.body, symbolize_names: :true) # Naming/VariableNumber: Use normalcase for variable numbers: parsed_top_20
        # Lint/BooleanSymbol: Symbol with a boolean name - you probably meant to use true.

      parsed_second_20 = JSON.parse(second_20.body, symbolize_names: :true) # Naming/VariableNumber: Use normalcase for variable numbers.
        # Lint/BooleanSymbol: Symbol with a boolean name - you probably meant to use true.
      @movies = (parsed_top_20[:results] << parsed_second_20[:results]).flatten
    end
  end

  def show
    movie_details = Faraday.get("https://api.themoviedb.org/3/movie/#{params[:id]}?api_key=#{ENV['MOVIES_API_KEY']}")
    @movie = JSON.parse(movie_details.body, symbolize_names: :true)

    cast_data = Faraday.get("https://api.themoviedb.org/3/movie/#{params[:id]}/credits?api_key=#{ENV['MOVIES_API_KEY']}")
    cast_json = JSON.parse(cast_data.body, symbolize_names: :true)
    @cast = cast_json[:cast].first(10) # refactor to .take(10)?

    review_data = Faraday.get("https://api.themoviedb.org/3/movie/#{params[:id]}/reviews?api_key=#{ENV['MOVIES_API_KEY']}")
    review_json = JSON.parse(review_data.body, symbolize_names: :true)
    @total_results = review_json[:total_results]
    @reviews = review_json[:results]
  end
end
