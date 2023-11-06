require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module AskABook
  class Application < Rails::Application
    config.load_defaults 7.1
    config.autoload_lib(ignore: %w(assets tasks))
    config.react.camelize_props = true 
    config.react.addons = true 
    config.exceptions_app = self.routes
  end
end
