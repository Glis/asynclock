class Location::Operation::Forecast < Trailblazer::Operation
  step Nested(Location::Operation::GetCoordinates)
  step :create_adapter
  step :get_locations,  fail_fast: true
  step :build_places

  def create_adapter(options, cached:, **)
    puts "cached aca me llega: #{cached}"
    options['adapter'] = Location::APIAdapter.new(cached)
  end

  def get_locations(options, locations:, adapter:, **)
    options['result_array'] = locations&.map do |name, coordinates|
      adapter.forecast_location(name, coordinates)
    end
  end

  def build_places(options, result_array:, **)
    options['places'] = result_array.map do |result|
      Location::Place.new(result)
    end
  end
end
