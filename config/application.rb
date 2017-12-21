require_relative 'boot'

require 'rails'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'active_job/railtie'
require 'action_cable/engine'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Mercury
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins *(ENV.fetch('CORS_ORIGINS').split(','))
        resource '*', headers: :any, methods: :any
      end
    end

    # Configures the URL options to use outside of the request context.
    config.action_mailer.default_url_options = {
      host: ENV.fetch('HOST'),
      protocol: ENV.fetch('PROTOCOL')
    }

    # Use Sidekiq for executing background jobs.
    config.active_job.queue_adapter = :sidekiq

    # Use Mandrill for delivering email.
    config.action_mailer.smtp_settings = {
      address: ENV.fetch('SMTP_ADDRESS'),
      authentication: :plain,
      domain: ENV.fetch('SMTP_DOMAIN'),
      enable_starttls_auto: true,
      password: ENV.fetch('SMTP_PASSWORD'),
      port: 587,
      user_name: ENV.fetch('SMTP_USERNAME')
    }

    # Use UUIDs in PostgreSQL by default.
    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
    end

    # Run ActionCable in-app.
    config.action_cable.mount_path = '/cable'

    # Configure ActionCable request origins.
    if ENV.fetch('ACTIONCABLE_REQUEST_ORIGINS') == 'false'
      config.action_cable.disable_request_forgery_protection = true
    else
      config.action_cable.allowed_request_origins = ENV.fetch('ACTIONCABLE_REQUEST_ORIGINS').split(',')
    end
  end
end
