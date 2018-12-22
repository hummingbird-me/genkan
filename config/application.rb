require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
# require "sprockets/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Genkan
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Don't generate system test files.
    config.generators.system_tests = nil

    # Set up default logger
    config.logger = Logger.new(STDERR)

    # Configure JWT
    if credentials.jwt.present?
      config.jwt_algorithm = credentials.jwt[:algorithm]
      config.jwt_private_key = OpenSSL::PKey.read(credentials.jwt[:private_key])
      config.jwt_public_key = OpenSSL::PKey.read(credentials.jwt[:public_key])
    elsif Rails.env.production?
      config.logger.error 'Production mode requires configuration of Rails credentials'
    else
      config.logger.warn 'No credentials found; generating random key.'
      # Just generate a new key at startup when we don't have credentials
      config.jwt_algorithm = 'RS256'
      config.jwt_private_key = OpenSSL::PKey::RSA.generate(2048)
      config.jwt_public_key = config.jwt_private_key.public_key
    end

    # Configure Redis
    redis_config = config_for(:redis)
    config.redis = ConnectionPool.new(redis_config[:pool] || {}) { Redis.new(redis_config) }
  end
end
