Rails.application.config.after_initialize do
  places = {
    'santiago': '-33.4378,-70.6504',
    'zurich': '47.3769,8.5414',
    'auckland': '-36.8535,174.7656',
    'sydney': '-33.8548,151.2165',
    'london': '51.5073,-0.1276',
    'georgia': '32.3294,-83.1137'
  }

  $redis.set 'place_coordinates', places.to_json
end
