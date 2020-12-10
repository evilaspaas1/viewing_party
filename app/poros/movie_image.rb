class MovieImage
  attr_reader :image

  def initialize(attributes)
    @image = attributes[:file_path]
  end
end
