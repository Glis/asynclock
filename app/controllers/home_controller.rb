class HomeController < ApplicationController
  def index
    @operation = Location::Operation::GetCoordinates.(params)
  end
end
