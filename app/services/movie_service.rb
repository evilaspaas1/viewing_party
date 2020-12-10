class MovieService
  def self.movies_by_search(search_term)
    results = conn.get('/3/search/movie') do |req|
      req.params[:query] = search_term
    end
    parse(results)
  end

  def self.top_movies_by_pages(page_number)
    conn.get('/3/movie/top_rated?') do |req|
      req.params[:page] = page_number
      req.params[:language] = 'en-US'
    end
  end

  def self.top_40_movies
    top20 = top_movies_by_pages(1)
    second20 = top_movies_by_pages(2)
    parsed_top20 = parse(top20)
    parsed_second20 = parse(second20)
    (parsed_top20[:results] << parsed_second20[:results]).flatten
  end

  def self.movie_data(movie_id)
    results = conn.get("/3/movie/#{movie_id}")
    parse(results)
  end

  def self.cast_data(movie_id)
    results = conn.get("/3/movie/#{movie_id}/credits?")
    parse(results)[:cast].take(10)
  end

  def self.review_data(movie_id)
    results = conn.get("/3/movie/#{movie_id}/reviews?")
    parse(results)
  end

  def self.get_movie_image(movie_id)
    results = conn.get("/3/movie/#{movie_id}/images?")
    parse(results)[:posters].first
  end

  def self.conn
    Faraday.new(url: 'https://api.themoviedb.org') do |f|
      f.params[:api_key] = ENV['MOVIES_API_KEY']
      f.params[:include_adult] = "false"
    end
  end

  def self.parse(results)
    JSON.parse(results.body, symbolize_names: true)
  end
end
