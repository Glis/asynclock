class HomeController < ApplicationController
  def index
    @locations = Forecaster.get_initial_coordinates
  end
end
