require_relative 'boot'
require 'rails/all'

Bundler.require(*Rails.groups)

module QuoLux
  class Application < Rails::Application
    config.active_job.queue_adapter = :sucker_punch
    config.active_record.timestamped_migrations = false
    config.load_defaults 5.1
    config.eager_load_paths << Rails.root.join('lib')
  end
end
