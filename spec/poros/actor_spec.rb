require "rails_helper"

describe "Actor Poro" do
  it "has attributes" do
    actor_name =
        {
            "name": "Tom Hanks",
        }

    actor = Actor.new(actor_name)

    expect(actor.name).to eq(actor_name[:name])
  end
end
