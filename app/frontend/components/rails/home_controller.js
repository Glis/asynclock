// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"

export default class extends Controller {
  connect() {
    console.log('connect home');

    this.initPolling();
  }

  initPolling() {
    // Initial Request
    this.requestCount = this.count(0);

    // Set clock process to poll for data every 10 secs
    setInterval(() => {
      this.requestCount = this.count(this.requestCount);
    }, 10000);
  }

  count(counter){
    console.log(`Updating view. Request #${counter}`);
    return counter+1;
  }
}
