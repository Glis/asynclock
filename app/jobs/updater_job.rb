class UpdaterJob < ApplicationJob
  queue_as :default

  def perform
    UpdaterChannel.send_data_update
  end
end
