class Location::Place
  attr_accessor :name, :latitude, :longitude, :timezone, :unixtime, :localtime_formatted, :temperature_f, :temperature_c, :info_hash

  def initialize(api_result)
    self.name = api_result['name']
    self.latitude = api_result['latitude']
    self.longitude = api_result['longitude']
    self.timezone = api_result['timezone']
    self.info_hash = api_result['currently']
    self.unixtime = info_hash['time']
    self.localtime_formatted = localtime.strftime('%I:%M:%S %P')
    self.temperature_f = info_hash['temperature']
    self.temperature_c = calculate_temperature_c.to_f
  end

  def localtime
    TZInfo::Timezone.get(timezone).utc_to_local(Time.at(unixtime))
  end

  private

  def calculate_temperature_c
    sprintf('%.2f', fahrenheith_to_celsius(temperature_f))
  end

  def fahrenheith_to_celsius(fahrenheit)
    (fahrenheit - 32) * 5 / 9
  end
end
