// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction

import { Controller } from "stimulus"
import { initUpdaterChannel, setUpdaterCallback } from "../../cable/channels/updater";

export default class extends Controller {
  static targets = ['santiagoTime', 'santiagoTempF', 'santiagoTempC',
                    'zurichTime', 'zurichTempF', 'zurichTempC',
                    'aucklandTime', 'aucklandTempF', 'aucklandTempC',
                    'sydneyTime', 'sydneyTempF', 'sydneyTempC',
                    'londonTime', 'londonTempF', 'londonTempC',
                    'georgiaTime', 'georgiaTempF', 'georgiaTempC'];

  connect() {
    // Initializes and connects to the updater channel
    initUpdaterChannel();

    // Sets the callback to execute then receiving the data
    setUpdaterCallback((receivedDataArray) => {
      console.log('Received update! Data to update:');
      console.log(receivedDataArray);

      this._updatePlacesInfo(receivedDataArray);
    });
  }

  _updatePlacesInfo(receivedDataArray){
    receivedDataArray.forEach((placeObject) => {
      this._renderPlaceInfo(placeObject)
    });
  }

  _renderPlaceInfo(place){
    let name = place['name'];
    let fahrenheitSuffix = "<small class='text-secondary'> ºF</small>";
    let celsiusSuffix = "<small class='text-secondary'> ºC</small>";

    this[`${name}TimeTarget`].innerHTML = place.localtime_formatted;
    this[`${name}TempFTarget`].innerHTML = `${place.temperature_f}${fahrenheitSuffix}`;
    this[`${name}TempCTarget`].innerHTML = `${place.temperature_c}${celsiusSuffix}`;
  }
}
