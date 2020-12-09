class MovieFacade

  def self.movies_by_search(search_term)
    movies = MovieService.movies_by_search(search_term)
    movies[:results].map do |movie|
      MovieDetails.new(movie)
    end
  end

  def self.top_40_movies
    movies = MovieService.top_40_movies
    movies.map do |movie|
      MovieDetails.new(movie)
    end
  end

  def self.movie_data(movie_id)
    movie = MovieService.movie_data(movie_id)
    MovieDetails.new(movie)
  end
end
