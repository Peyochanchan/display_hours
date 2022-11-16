require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module DisplayHours
  class Application < Rails::Application
    config.generators do |generate|
      generate.assets false
      generate.helper false
      generate.test_framework :test_unit, fixture: false
    end
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

  end
end
