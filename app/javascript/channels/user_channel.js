import consumer from "./consumer"

document.addEventListener('turbolinks:load', () => {

  const userElement = document.getElementById('user');

  if (userElement == null) return;

  const user_id = userElement.getAttribute('data-user-id');

  consumer.subscriptions.create( { channel: "UserChannel", user_id: user_id }, {
    connected() {
      // Called when the subscription is ready for use on the server
      console.log('Connected to user channel ' + user_id);
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      // Called when there's incoming data on the websocket for this channel
      console.log(data);
    }
  });
});
