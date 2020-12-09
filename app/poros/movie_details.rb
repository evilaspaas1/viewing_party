class MovieDetails
  attr_reader :vote_average,
              :runtime,
              :genres,
              :overview

  def initialize(attributes)
# binding.pry
    @vote_average = attributes[:vote_average]
    @runtime = attributes[:runtime]
    @genres = attributes[:genres]
    @overview = attributes[:overview]
  end
end
