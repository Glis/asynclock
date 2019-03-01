class UpdaterChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'updater_channel'
  end

  def unsubscribed
    stop_all_streams
  end

  # Called by the rake task
  def self.send_data_update
    @operation = Location::Operation::Forecast.call(nil,cached: ENV['API_REQUESTS_ENABLED'].blank?)
    if @operation.success?
      ActionCable.server.broadcast('updater_channel', locationsData: @operation['places'])
    else
      puts 'Error in the forecast operation'
    end
  end
end
