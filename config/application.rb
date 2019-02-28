require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Asynclock
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Delete all keys from redis at finishing the app
    at_exit do
      # Redis.current.flushdb
      $redis.del('place_coordinates', 'zurich_mockup', 'georgia_mockup', 'auckland_mockup', 'santiago_mockup', 'sydney_mockup', 'london_mockup') if $redis.present?
    end
  end
end
