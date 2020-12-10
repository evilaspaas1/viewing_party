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

  def self.cast_data(movie_id)
    cast = MovieService.cast_data(movie_id)
    cast.map do |actor|
      Actor.new(actor)
    end
  end

  def self.review_data(movie_id)
    reviews = MovieService.review_data(movie_id)
    reviews[:results].map do |review|
      Review.new(review)
    end
  end

  def self.total_reviews(movie_id)
    review_data(movie_id).count
  end
end
