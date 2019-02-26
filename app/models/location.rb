class Location
  attr_accessor :name, :latitude, :longitude, :timezone, :unixtime, :temperature_f, :info_hash

  def initialize(name, api_result)
    self.name = name
    self.latitude = api_result['latitude']
    self.longitude = api_result['longitude']
    self.timezone = api_result['timezone']
    self.info_hash = api_result['currently']
    self.unixtime = info_hash['time']
    self.temperature_f = info_hash['temperature']
  end

  def localtime
    TZInfo::Timezone.get(timezone).utc_to_local(Time.at(unixtime))
  end

  def localtime_formatted
    localtime.strftime('%I:%M:%S %P')
  end

  def temperature_c
    sprintf('%.2f', fahrenheith_to_celsius(temperature_f))
  end

  private

  def fahrenheith_to_celsius(fahrenheit)
    (fahrenheit - 32) * 5 / 9
  end
end
