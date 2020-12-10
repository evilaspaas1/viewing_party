class PartyController < ApplicationController
  def new
    @movie = Movie.find_by(api_id: params[:api_id])
    @movie || @movie = Movie.create!({ title: params[:title], duration: params[:duration], api_id: params[:api_id] })
  end

  def create
    party = Party.new(party_params)
    if party.save && params[:friends]
      Guest.create!(party_id: party.id, user_id: current_user.id)
      params[:friends][:ids].each do |id|
        Guest.create!(party_id: party.id, user_id: id) unless id == ''
      end
      redirect_to dashboard_index_path
    elsif party.save
      Guest.create!(party_id: party.id, user_id: current_user.id)
      redirect_to dashboard_index_path
    else
      @movie = Movie.find_by(id: params[:movie_id])
      flash[:notice] = party.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def party_params
    params.permit(:date, :duration, :start_time, :movie_id, :user_id)
  end
end
