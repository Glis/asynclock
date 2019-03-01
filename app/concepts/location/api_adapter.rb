class Location::APIAdapter
  API_BASE_URL = "https://api.darksky.net/forecast/#{ENV['FORECAST_API_KEY'] || Rails.application.credentials.forecast_api_key}"

  attr_accessor :cached

  def initialize(is_cached=true)
    self.cached = is_cached
  end

  def forecast_location(name, coordinates)
    url = "#{API_BASE_URL}/#{coordinates}"
    puts url

    result = try_request(name, url) while result.nil?

    parsed_result = JSON.parse(result)
    parsed_result['name'] = name
    parsed_result
  end

  private

  def try_request(name, url)
    if Random.rand < 0.1
      raise 'How unfortunate! The API Request Failed'
    else
      cached ? cached_request(name, url) : api_request(url)
    end
  rescue RuntimeError => error
    $redis.hset('api.errors', Time.now.to_s, error.inspect)
    puts 'Error: se guardó en api.errors'
  end

  def cached_request(name, url)
    if $redis.exists("#{name}_mockup")
      puts 'CACHE HIT: Taking places_hash from cache'
      result = $redis.get("#{name}_mockup")
    else
      result = api_request(url)
      $redis.set("#{name}_mockup", result)
    end
    result
  end

  def api_request(url)
    puts 'API HIT: Getting places_hash from API'
    RestClient.get(url)
  end
end