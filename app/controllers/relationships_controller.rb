class RelationshipsController < ApplicationController
  def create
    current_user.follow(params[:user_id])
    @user = User.find(params[:user_id])
     if current_user.mutual_followed?(@user.id)
      rooms = current_user.user_rooms.pluck(:room_id)
      match_room = UserRoom.find_by(user_id: @user.id, room_id: rooms)
      if match_room.blank?
        new_room = Room.new
        new_room.save
        UserRoom.create(user_id: current_user.id, room_id: new_room.id)
        UserRoom.create(user_id: @user.id, room_id: new_room.id)
      end
     end
  end

  def destroy
    current_user.unfollow(params[:user_id])
    @user = User.find(params[:user_id])
  end
end
