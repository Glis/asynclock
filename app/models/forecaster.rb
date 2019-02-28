class Forecaster
  API_BASE_URL = "https://api.darksky.net/forecast/#{Rails.application.credentials.forecast_api_key}"

  def self.get_initial_coordinates
    JSON.parse($redis.get('place_coordinates')) if $redis.exists('place_coordinates')
  end

  def self.get_locations
    cities = get_initial_coordinates

    cities.map { |name, coordinates| Forecaster.location_forecast(name, coordinates) } if $redis.keys.present?
  end

  def self.location_forecast(name, coordinates)
    url = "#{API_BASE_URL}/#{coordinates}"
    result = try_request(name, url) while result.nil?

    Location.new(name, parseJSON(result))
  end

  def self.try_request(name, url)
    if Random.rand < 0.1
      raise 'How unfortunate! The API Request Failed'
    else
      cached_request(name, url)
    end
  rescue RuntimeError => error
    $redis.hset('api.errors', Time.now.to_s, error.inspect)
    puts 'Error: se guardó en api.errors'
  end

  def self.cached_request(name, url)
    if $redis.exists("#{name}_mockup")
      puts 'CACHE HIT: Taking places_hash from cache'
      result = $redis.get("#{name}_mockup")
    else
      puts 'API HIT: Getting places_hash from API'
      result = api_request(url)
      $redis.set("#{name}_mockup", result)
    end
    result
  end

  def self.api_request(url)
    RestClient.get(url)
  end

  private

  def self.parseJSON(result)
    JSON.parse(result)
  end
end