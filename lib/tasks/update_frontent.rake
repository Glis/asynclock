desc 'Loop and queue an update each 10 seconds'
task :start_forecast_broadcast_loop => :environment do
  p '---Starting front update loop...'
  loop do
    p '---Update data...'
    UpdaterChannel.send_data_update
    p '---sleeping for 10 seconds...'
    sleep 10
  end
end