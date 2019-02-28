// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"
import { initChannel, setUpdaterCallback } from "../../cable/channels/updater";

export default class extends Controller {

  static targets = ['santiagoTime', 'santiagoTempF', 'santiagoTempC',
                    'zurichTime', 'zurichTempF', 'zurichTempC',
                    'aucklandTime', 'aucklandTempF', 'aucklandTempC',
                    'sydneyTime', 'sydneyTempF', 'sydneyTempC',
                    'londonTime', 'londonTempF', 'londonTempC',
                    'georgiaTime', 'georgiaTempF', 'georgiaTempC'];

  connect() {
    console.log('connect home');

    // Initializes and connects to the updater channel
    initChannel("UpdaterChannel");

    // Sets the callback to execute then receiving the data
    setUpdaterCallback((receivedDataArray) => {
      console.log('Received update! Data to update:');
      console.log(receivedDataArray);
      console.log('Updating front components');

      this._updatePlacesInfo(receivedDataArray);
    });
  }

  _updatePlacesInfo(receivedDataArray){
    receivedDataArray.forEach((placeObject) => {
      let placeName = placeObject['name'];
      let fahrenheitSuffix = "<small class='text-secondary'> ºF</small>";
      let celsiusSuffix = "<small class='text-secondary'> ºC</small>";

      this[`${placeName}TimeTarget`].innerHTML = placeObject.localtime_formatted;
      this[`${placeName}TempFTarget`].innerHTML = `${placeObject.temperature_f}${fahrenheitSuffix}`;
      this[`${placeName}TempCTarget`].innerHTML = `${placeObject.temperature_c}${celsiusSuffix}`;
    });
  }
}
