class MovieFacade

  def self.movies_by_search(search_term)
    movies = MovieService.movies_by_search(search_term)
    movies[:results].map do |movie|
      MovieDetails.new(movie)
    end
  end

  def top_rated_movies
    @movie_service.top_rated_movies
  end
end
