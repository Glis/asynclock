class UpdaterChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'updater_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  # Called when message-form contents are received by the server
  def self.send_data_update
    data = { message: 'Prueba desde el backend' }

    ActionCable.server.broadcast 'updater', data: data
  end
end
