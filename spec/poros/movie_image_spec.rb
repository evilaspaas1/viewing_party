require 'rails_helper'

describe "Movie Image PORO" do
  it "has attributes" do
    image =
        {
            "file_path": "/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg",
        }

    image_obj = MovieImage.new(image)
    expect(image_obj.image).to eq(image[:file_path])
  end
end
