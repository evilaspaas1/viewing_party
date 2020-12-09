class MovieDetails
  attr_reader :vote_average,
              :runtime,
              :genres,
              :overview,
              :title,
              :id

  def initialize(attributes)
    @id = attributes[:id]
    @title = attributes[:title]
    @vote_average = attributes[:vote_average]
    @runtime = attributes[:runtime]
    @genres = attributes[:genres]
    @overview = attributes[:overview]
  end
end
