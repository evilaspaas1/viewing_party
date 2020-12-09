class PartyController < ApplicationController
  def new
    @movie = Movie.find_by(api_id: params[:api_id])
    @movie || Movie.create!({ title: params[:title], duration: params[:duration], api_id: params[:api_id] })
  end

  # def create
  #
  # end
end
