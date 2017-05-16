# frozen_string_literal: true

FactoryGirl.define do
  factory :device do
    association :profile
    type { Device.type.values.sample }
    source do
      {
        'token' => '740f4707 bebcf74f 9b7c25d4 8e335894 5f6aa01d a5ddb387 462c7eaf 61bb78ad',
        'apns_app' => FactoryGirl.create(:apns_app).id
      }
    end
  end
end
