require "rails_helper"

describe "Review Poro" do
  it "has attributes" do
    review_details =
        {
            "author_details": {
                "username": "elshaarawy",
            },
            "content": "very good movie 9.5/10 محمد الشعراوى",
        }

    review = Review.new(review_details)

    expect(review.username).to eq(review_details[:author_details][:username])
    expect(review.content).to eq(review_details[:content])
  end
end
