class FriendshipsController < ApplicationController

  def create
    new_friend = User.find_by(email: params[:email])

    create_friendship(current_user.id, new_friend)
    redirect_to "/dashboard"
  end

  def create_friendship(user_id, friend)
    if !friend
      flash[:error] = "I'm sorry your friend cannot be found"
    elsif friend.id == user_id
      flash[:error] = "You can not add yourself as a friend"
    elsif friend_exists?(friend)
      flash[:error] = "You have already added this friend"
    else friend
      Friendship.create({user_id: current_user.id, friend_id: friend.id})
    end
  end

  def friend_exists?(new_friend)
    current_user.friends.any? do |friend|
      friend.id == new_friend.id
    end
  end
end
