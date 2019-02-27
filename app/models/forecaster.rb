class Forecaster
  API_BASE_URL = "https://api.darksky.net/forecast/63ea13868359bc4c6e1117dcb3669f3b"

  def self.get_locations
    cities = JSON.parse($redis.get('place_coordinates'))

    cities.map { |name, coordinates| Forecaster.location_forecast(name, coordinates) }
  end

  def self.location_forecast(name, coordinates)
    url = "#{API_BASE_URL}/#{coordinates}"
    result = api_request(name, url) while result.nil?

    Location.new(name, parseJSON(result))
  end

  def self.api_request(name, url)
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
      result = RestClient.get(url)
      $redis.set("#{name}_mockup", result)
    end
    result
  end

  private

  def self.parseJSON(result)
    JSON.parse(result)
  end
end