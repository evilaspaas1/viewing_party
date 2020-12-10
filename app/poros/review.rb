class Review
  attr_reader :username,
              :content

  def initialize(attributes)
    @username = attributes[:author_details][:username]
    @content = attributes[:content]
  end
end
