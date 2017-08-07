require_relative 'boot'
require 'rails'
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'

Bundler.require(*Rails.groups)

module QuoLux
  class Application < Rails::Application
    config.active_job.queue_adapter = :sucker_punch
    config.active_record.timestamped_migrations = false
    config.load_defaults 5.1
    config.eager_load_paths << Rails.root.join('lib')

    config.action_mailer.delivery_method = :mailgun
    config.action_mailer.mailgun_settings = {
      api_key: '80051aaa36fd9b466a8ab06895457d05',
      domain: 'sandboxef69c7584d5a4540ae3194e3c9ad1794.mailgun.org'
    }
  end
end
