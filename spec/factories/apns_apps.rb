# frozen_string_literal: true

FactoryGirl.define do
  factory :apns_app do
    sequence(:name) { |n| "apns_app_#{n}" }
    environment 'development'
    certificate { File.read(Rails.root.join('spec', 'fixtures', 'files', 'cert.pem')) }
  end
end
