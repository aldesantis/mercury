# frozen_string_literal: true

namespace :mercury do
  desc 'Imports the APNS certificates.'
  task import_certs: :environment do
    Rpush::Apns::App.find_or_create_by(name: 'appc_development') do |app|
      app.certificate = File.read(Rails.root.join('.certs', 'appc_development.pem'))
      app.environment = 'development' # APNs environment.
      app.password = ENV.fetch('CERTS_PASSWORD')
      app.connections = 1
    end

    Rpush::Apns::App.find_or_create_by(name: 'appt_development') do |app|
      app.certificate = File.read(Rails.root.join('.certs', 'appt_development.pem'))
      app.environment = 'development' # APNs environment.
      app.password = ENV.fetch('CERTS_PASSWORD')
      app.connections = 1
    end
  end
end
