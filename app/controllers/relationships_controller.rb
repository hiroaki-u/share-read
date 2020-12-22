class RelationshipsController < ApplicationController
  def create
    user = User.find(params[:follow_id])
    current_user.follow(user)
    redierct_to user
  end

  def destroy
    user = User.find(params[:follow_id])
    current_user.unfollow(user)
    redierct_to user   
  end
end
