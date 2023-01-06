class RoomsController < ApplicationController
  before_action :mutual_related, only: [:show]
  def show
    @user = User.find(params[:id])
    rooms = current_user.user_rooms.pluck(:room_id)
    match_room = UserRoom.find_by(user_id: @user.id, room_id: rooms)
    @room = match_room.room
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
    form_instance
  end

  def create
    @chat = current_user.chats.new(chat_params)
    render :validater unless @chat.save
  end


  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

  def mutual_related
    user = User.find(params[:id])
     unless current_user.mutual_followed?(user)
      redirect_to user_path(user.id)
     end
  end
end
