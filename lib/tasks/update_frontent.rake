desc 'Loop and queue an update each 10 seconds'
task :start_forecast_broadcast_loop => :environment do
  p '---Starting front update loop...'
  loop do
    if UpdaterChannel.send_data_update
      p '--- Update data...'
    else
      p '--- Error reaching redis. Please restart the app'
    end
    p '---sleeping for 10 seconds...'
    sleep 10
  end
end