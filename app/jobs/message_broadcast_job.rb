class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast build_room_id(message.room_id),
                                 message: {
                                     content: message.content,
                                     username: message.user.username
                                 }
  end

  def build_room_id(id)
    "room_channel_#{id}"
  end
end
