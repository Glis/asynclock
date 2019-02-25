class HomeController < ApplicationController
  def index
    cities = JSON.parse($redis.get('place_coordinates'))

    # Place Information Hash
    @places = {}
    cities.each do |name, coordinates|
      @places[name] = Forecaster.forecast(name, coordinates)
    end
  end

  def forecast
    $redis.set 'forecast mockup', places.to_json
  end
end
