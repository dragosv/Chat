import consumer from "./consumer"

document.addEventListener('turbolinks:load', () => {

  const conversationElement = document.getElementById('conversation');

  if (conversationElement == null) return;

  const conversation_id = conversationElement.getAttribute('data-conversation-id');

  consumer.subscriptions.create( { channel: "ConversationChannel", conversation_id: conversation_id }, {
    connected() {
      // Called when the subscription is ready for use on the server
      console.log('Connected to conversation channel ' + conversation_id);
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      // Called when there's incoming data on the websocket for this channel
      console.log(data);

      const messagesElement = document.getElementById('messages');

      messagesElement.innerHTML = messagesElement.innerHTML +
          "<div class=\"message-content\">" +
          data.message.content +
          "</div><div class=\"message-user\">" +
          data.message.email +
          "</div>";
    }
  });
});
