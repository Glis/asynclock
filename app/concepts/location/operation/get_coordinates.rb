class Location::Operation::GetCoordinates < Trailblazer::Operation
  step :fetch_initial_coordinates, fail_fast: true
  step :parse

  def fetch_initial_coordinates(_options, **)
    $redis.exists('place_coordinates')
  end

  def parse(options, **)
    options['locations'] = JSON.parse($redis.get('place_coordinates'))
  end
end
