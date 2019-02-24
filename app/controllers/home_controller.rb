class HomeController < ApplicationController
  def index
    api_key = Rails.application.credentials.forecast_api_key
    cities = JSON.parse($redis.get('place_coordinates'))

    # Place Information Hash
    @places = {}
    cities.each do |name, coordinates|
      # rest-client requests
      url = "https://api.darksky.net/forecast/#{api_key}/#{coordinates}"
      result = JSON.parse(RestClient.get(url))

      @places[name] ||= {}
      @places[name]['latitude'] = result['latitude']
      @places[name]['longitude'] = result['longitude']
      @places[name]['timezone_name'] = result['timezone']
      @places[name]['currently'] = result['currently']
      @places[name]['unixtime'] = result['currently']['time']
      @places[name]['localtime'] = TZInfo::Timezone.get(@places[name]['timezone_name']).utc_to_local(Time.at(@places[name]['unixtime']))
      @places[name]['localtime_formatted'] = @places[name]['localtime'].strftime("%I:%M %p")
      @places[name]['temperature_f'] = result['currently']['temperature']
      @places[name]['temperature_c'] = sprintf('%.2f', fahrenheith_to_celsius(result['currently']['temperature']))
    end
  end

  private

  def fahrenheith_to_celsius fahrenheit
    (fahrenheit - 32) * 5 / 9
  end
end
