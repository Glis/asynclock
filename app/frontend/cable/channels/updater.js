import createChannel from "../cable";

let callback; // declaring a variable that will hold a function later
let updater;

// Function that initializes a channel
function initChannel(channelName) {
  updater = createChannel(channelName, {
    connected: () => {
      console.log('connected! to the updater');
    },
    disconnected: function() {
      console.log('disconnected! to the updater');
    },
    received: ({ locationsData }) => {
      if (callback) callback.call(null, locationsData);
    }
  });
}

// Received callvack: this callback will be invoked once we receive something over channel
function setUpdaterCallback(fn) {
  callback = fn;
}

export { initChannel, setUpdaterCallback };