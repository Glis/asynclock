import createChannel from "../cable";

let callback; // Declaring a variable that will hold a function later
let updater; // Cable Consumer instance

// Function that initializes the channel
function initUpdaterChannel() {
  updater = createChannel("UpdaterChannel", {
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

// Received callback: this callback will be invoked once we receive something over channel
function setUpdaterCallback(fn) {
  callback = fn;
}

export { initUpdaterChannel, setUpdaterCallback };