import createChannel from "../cable";

let callback; // declaring a variable that will hold a function later
let updater;

// Sending a message: "perform" method calls a respective Ruby method
// defined in chat_channel.rb. That's your bridge between JS and Ruby!
function initChannel() {
  updater = createChannel({channel: "UpdaterChannel"}, {
    connected: () => {
      console.log('connected! to the updater');
    },
    received: (data) => {
      console.log('print this when message is broadcasted');
      // if (callback) callback.call(null, data);
    }
  });
}

// Getting a message: this callback will be invoked once we receive
// something over ChatChannel
function setUpdaterCallback(fn) {
  callback = fn;
}

export { initChannel, setUpdaterCallback };