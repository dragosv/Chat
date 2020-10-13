import consumer from "./consumer"

document.addEventListener('turbolinks:load', () => {

  const roomElement = document.getElementById('room');

  if (roomElement == null) return;

  const room_id = roomElement.getAttribute('data-room-id');

  consumer.subscriptions.create( { channel: "RoomChannel", room_id: room_id }, {
    connected() {
      // Called when the subscription is ready for use on the server
      console.log('Connected to room channel ' + room_id);
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
          data.message.username +
          "</div>";
    }
  });
});
