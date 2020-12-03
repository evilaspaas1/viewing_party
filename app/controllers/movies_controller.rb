class MoviesController < ApplicationController
  def index
    if params[:search] == ""
      flash[:error] = "Must provide a search query"
      redirect_to "/discover"
    end 
  end
end
