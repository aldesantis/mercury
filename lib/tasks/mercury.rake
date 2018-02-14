# frozen_string_literal: true

namespace :mercury do
  desc 'Imports the APNS certificates.'
  task import_certs: :environment do
    %w[appc appt].each do |app_name|
      %w[development production].each do |env|
        app = Rpush::Apns::App.find_or_initialize_by(name: "#{app_name}_#{env}")

        app.certificate = File.read(Rails.root.join('.certs', "#{app_name}_#{env}.pem"))
        app.environment = env
        app.password = ENV.fetch('CERTS_PASSWORD')
        app.connections = 1

        app.save!
      end
    end
  end
end
