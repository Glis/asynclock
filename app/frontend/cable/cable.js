// Action Cable provides the framework to deal with WebSockets in Rails.
// You can generate new channels where WebSocket features live using the `rails generate channel` command.

import cable from "actioncable";

let consumer;

function createChannel(...args) {
  let cableRoute = '/cable'
  if (document.querySelectorAll('meta[name=action-cable-url]').length) {
     cableRoute = document.querySelectorAll('meta[name=action-cable-url]')[0].getAttribute('content')
  }
  if (!consumer) {
    consumer = cable.createConsumer(cableRoute);
  }

  return consumer.subscriptions.create(...args);
}

export default createChannel;