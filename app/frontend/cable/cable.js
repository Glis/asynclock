// Action Cable provides the framework to deal with WebSockets in Rails.
// You can generate new channels where WebSocket features live using the `rails generate channel` command.

import ActionCable from "actioncable";

let consumer;

function createChannel(...args) {
  if (!consumer) {
    consumer = ActionCable.createConsumer();
  }

  return consumer.subscriptions.create(...args);
}

export default createChannel;