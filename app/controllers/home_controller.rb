class HomeController < ApplicationController
  def index
    @locations = Forecaster.get_locations
  end
end
