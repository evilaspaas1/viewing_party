class MoviesController < ApplicationController
  def index
    search_term = params[:search]
    if search_term == ''
      flash[:error] = 'Must provide a search query'
      redirect_to '/discover'
    elsif search_term
      @movies = MovieFacade.movies_by_search(search_term)
      @trending_movies = MovieFacade.trending_movies
    else
      @movies = MovieFacade.top_40_movies
      @trending_movies = MovieFacade.trending_movies
    end
  end

  def show
    movie_id = params[:id]
    @movie = MovieFacade.movie_data(movie_id)
    @cast = MovieFacade.cast_data(movie_id)
    @reviews = MovieFacade.review_data(movie_id)
    @total_results = MovieFacade.total_reviews(movie_id)
    @movie_image = MovieFacade.get_movie_image(movie_id)
  end
end
