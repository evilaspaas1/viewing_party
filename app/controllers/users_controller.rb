class UsersController < ApplicationController
  def new
  end

  def create
    user = User.new(user_params)
    if user.save
      flash[:success] = "You are now registered and logged in."
      session[:user_id] = user.id
      redirect_to dashboard_index_path
    else
      flash[:error] = user.errors.full_messages.to_sentence
      render :new
    end
  end


  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

end
