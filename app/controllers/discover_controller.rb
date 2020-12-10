class DiscoverController < ApplicationController
  def index
    @trending_movies = MovieFacade.trending_movies
  end
end
