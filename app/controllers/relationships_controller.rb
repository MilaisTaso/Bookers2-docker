class RelationshipsController < ApplicationController
  def create
    follow = current_user.follow(params[:user_id])
    @user = User.find(params[:user_id])
    # if
    #   followed = Relationship.find_by(follower_id: @user.id, followed_id: current_user.id)
    #   follow.add_room(followed.id)
    # end
  end

  def destroy
    current_user.unfollow(params[:user_id])
    @user = User.find(params[:user_id])
  end
end
