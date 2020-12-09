class MovieService

  def self.movies_by_search(search_term)
    results = conn.get("/3/search/movie") do |req|
      req.params[:query] = search_term
    end
    self.parse(results)
  end

  def self.top_movies_by_pages(page_number)
    results = conn.get("/3/movie/top_rated?") do |req|
      req.params[:page] = page_number
      req.params[:language] = "en-US"
    end
  end

  def self.top_40_movies
    top_20 = self.top_movies_by_pages(1)
    second_20 = self.top_movies_by_pages(2)
    parsed_top_20 = self.parse(top_20)
    parsed_second_20= self.parse(second_20)
    (parsed_top_20[:results] << parsed_second_20[:results]).flatten
  end

  def self.movie_data(movie_id)
    results = conn.get("/3/movie/#{movie_id}")
    self.parse(results)
  end

  def self.cast_data(movie_id)
    results = conn.get("/3/movie/#{movie_id}/credits?")
    self.parse(results)[:cast].take(10)
  end

  def self.review_data(movie_id)
    results = conn.get("/3/movie/#{movie_id}/reviews?")
    self.parse(results)
  end

private

  def self.conn
    Faraday.new(url: "https://api.themoviedb.org") do |f|
      f.params[:api_key] = ENV['MOVIES_API_KEY']
      # f.headers["include_adult"] = "false"
    end
  end

  def self.parse(results)
    JSON.parse(results.body, symbolize_names: :true)
  end
end
