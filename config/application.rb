require_relative "boot"

require "rails"

%w(
  active_record/railtie
  action_controller/railtie
  action_view/railtie
  active_job/railtie
  action_cable/engine
  rails/test_unit/railtie
).each do |railtie|
    begin
    require railtie
  rescue LoadError
  end
end

Bundler.require(*Rails.groups)

module DisplayHours
  class Application < Rails::Application
    config.generators do |generate|
      generate.assets false
      generate.helper false
      generate.test_framework :test_unit, fixture: false
    end
    config.load_defaults 7.0

    #I18n Setup
    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
    I18n.available_locales = %i[fr en]
    config.i18n.default_locale = :en

    config.before_configuration do
      env_file = File.join(Rails.root, 'config', 'local_env.yml')
      YAML.load(File.open(env_file)).each do |key, value|
        ENV[key.to_s] = value
      end if File.exists?(env_file)
    end

    # config.time_zone = 'Paris'
  end
end
