class ChatMessagesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @chat_message = ChatMessage.new
    @room = Room.find(params[:room_id])
    @chat_messages = @room.chat_messages.includes(:user)
  end

  def create
    @room = Room.find(params[:room_id])
    @chat_message = @room.chat_messages.new(chat_message_params)

    if @chat_message.save
      redirect_to room_chat_messages_path(@room)
    else
      @chat_messages = @room.chat_messages.includes(:user)
      render :index
    end
  end

  private

  def chat_message_params
    params.require(:chat_message).permit(:content, :image).merge(user_id: current_user.id)
  end
end
