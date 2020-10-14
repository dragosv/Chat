class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  def get_rooms
    @rooms = Room.all

    respond_to do |format|
      format.all { render json: @rooms }
    end
  end

  def create_room
    @room = Room.new(room_params)

    if @room.save
      respond_to do |format|
        format.all { render json: @room }
      end
    else
      respond_to do |format|
        format.all { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  def get_messages
    @room = Room.find(params[:id])

    respond_to do |format|
      format.all { render json: @room.messages }
    end
  end

  def create_message
    room = Room.find(params[:id])

    @message = Message.new(message_params)

    begin
      user = User.find(@message.user_id)
    rescue ActiveRecord::RecordNotFound
      respond_to do |format|
        format.all { render json: { 'user_id' => 'user does not exists' }, status: :unprocessable_entity }
      end

      return
    end

    @message.room = room
    @message.user = user

    if @message.save
      MessageBroadcastJob.perform_later @message

      respond_to do |format|
        format.all { render json: @message }
      end
    else
      respond_to do |format|
        format.all { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :user_id)
  end

  def room_params
    params.require(:room).permit(:name)
  end
end
