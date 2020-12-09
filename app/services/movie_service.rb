class MovieService

  def self.movies_by_search(search_term)
    results = conn.get("/3/search/movie") do |req|
      req.params[:query] = search_term
    end

    JSON.parse(results.body, symbolize_names: :true)
  end





private

  def self.conn
    Faraday.new(url: "https://api.themoviedb.org") do |f|
      f.params[:api_key] = ENV['MOVIES_API_KEY']
      # f.headers["include_adult"] = "false"
    end
  end

end
