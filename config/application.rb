require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Qpp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    Rails.application.config.assets.precompile += %w( zoom/tools.js )
    Rails.application.config.assets.precompile += %w( tools.js )
    Rails.application.config.assets.precompile += %w( zoom/vconsole.min.js )
    Rails.application.config.assets.precompile += %w( vconsole.min.js )
    Rails.application.config.assets.precompile += %w( zoom/meeting.js )
    Rails.application.config.assets.precompile += %w( meeting.js )


    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
