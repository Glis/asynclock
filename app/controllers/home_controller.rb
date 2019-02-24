class HomeController < ApplicationController
  def index
    cities = JSON.parse($redis.get('place_coordinates'))
    @city_information = {}
    cities.each do |name, coordinates|
      @city_information[name] ||= {}
      @city_information[name]['latitude'] = coordinates.split(',').first
      @city_information[name]['longitude'] = coordinates.split(',').last
    end
  end
end
