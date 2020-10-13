class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message, from, to)
    ActionCable.server.broadcast build_user_room_id(to.user_id),
                                 from: {
                                     user: from.user_id,
                                     conversation: message.conversation.id
                                 }

    ActionCable.server.broadcast build_conversation_room_id(message.room_id),
                                 message: {
                                     content: message.content,
                                     from: message.conversation.from.email,
                                     to: message.conversation.to.email
                                 }
  end

  def build_user_room_id(id)
    "user_channel_#{id}"
  end

  def build_conversation_room_id(id)
    "conversation_channel_#{id}"
  end
end
