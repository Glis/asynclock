class UpdaterChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'updater_channel'
  end

  def unsubscribed
    stop_all_streams
  end

  # Called when message-form contents are received by the server
  def self.send_data_update
    locations = Forecaster.get_locations

    ActionCable.server.broadcast('updater_channel', locationsData: locations) if locations.present?
  end
end
