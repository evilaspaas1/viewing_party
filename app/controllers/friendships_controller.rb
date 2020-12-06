class FriendshipsController < ApplicationController

  def create
    friend = User.find_by(email: params[:email])
    if friend
      Friendship.create({user_id: current_user.id, friend_id: friend.id})
    else
      flash[:errors] = "I'm sorry your friend cannot be found"
    end

    redirect_to "/dashboard"
  end
end
