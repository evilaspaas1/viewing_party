class SessionsController < ApplicationController

  def new
    flash[:notice] = "You are already logged in!" if current_user
    redirect_to "/dashboard"
  end

  def create
    user = User.find_by(login_params)
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}" if current_user
      redirect_to "/dashboard"
    else
      flash[:error] = "Your log in credentials are bad."
      redirect_to "/"
    end
  end

  def destroy
    reset_session
    flash[:notice] = "You are now logged out"
    redirect_to root_path
  end

  private

  def login_params
    params.permit(:email)
  end
end
