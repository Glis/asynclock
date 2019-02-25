class Forecaster
  API_BASE_URL = "https://api.darksky.net/forecast/#{Rails.application.credentials.forecast_api_key}"

  def self.forecast(name, coordinates)
    url = "#{API_BASE_URL}/#{coordinates}"
    result = api_request(url) while result.nil?

    PlaceInformation.new(name, parseJSON(result))
  end

  def self.api_request(url)
    if Random.rand < 0.1
      raise 'How unfortunate! The API Request Failed'
    else
      cached_request(url)
    end
  rescue => exception
    $redis.hset('api.errors', Time.now.to_s, exception)
    puts 'EXCEPTION: se guardó en api.errors'
  end

  def self.cached_request(url)
    if($redis.exists('places_coordinates_mockup'))
      puts 'CACHE HIT: Taking places_hash from cache'
      result = $redis.get('places_coordinates_mockup')
    else
      puts 'API HIT: Getting places_hash from API'
      result = RestClient.get(url)
      $redis.set('places_coordinates_mockup', result)
    end
    result
  end

  private

  def self.parseJSON(result)
    JSON.parse(result)
  end
end