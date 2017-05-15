# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

Rpush::Apns::App.find_or_create_by(name: 'ios_appc_development') do |app|
  app.certificate = File.read(Rails.root.join('config', 'certificates', 'appc_development.pem'))
  app.environment = 'development'
  app.password = ENV.fetch('APNS_CERTS_PASSWORD')
  app.connections = 1
end

# Rpush::Apns::App.find_or_create_by(name: 'ios_appc_production') do |app|
#   app.certificate = File.read(Rails.root.join('config', 'certificates', 'appc_production.pem'))
#   app.environment = 'production'
#   app.password = ENV.fetch('APNS_CERTS_PASSWORD')
#   app.connections = 1
# end

Rpush::Apns::App.find_or_create_by(name: 'ios_appt_development') do |app|
  app.certificate = File.read(Rails.root.join('config', 'certificates', 'appt_development.pem'))
  app.environment = 'development'
  app.password = ENV.fetch('APNS_CERTS_PASSWORD')
  app.connections = 1
end

# Rpush::Apns::App.find_or_create_by(name: 'ios_appt_production') do |app|
#   app.certificate = File.read(Rails.root.join('config', 'certificates', 'appt_production.pem'))
#   app.environment = 'production'
#   app.password = ENV.fetch('APNS_CERTS_PASSWORD')
#   app.connections = 1
# end
