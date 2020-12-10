class PartyController < ApplicationController

  def new
    @movie = Movie.find_by(api_id: params[:api_id])
    if @movie
      @movie
    else
      @movie = Movie.create!({title: params[:title], duration: params[:duration], api_id: params[:api_id]})
    end
  end

  def create
    party = Party.new(party_params)
    if party.save && params[:friends]
      Guest.create!(party_id: party.id, user_id: current_user.id)
      params[:friends][:ids].each do |id|
        unless id == ""
          Guest.create!(party_id: party.id, user_id: id)
        end
      end
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
