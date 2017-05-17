# frozen_string_literal: true

FactoryGirl.define do
  factory :device do
    association :profile
    type { Device.type.values.sample }
    source do
      {
        'token' => '740f4707bebcf74f9b7c25d48e3358945f6aa01da5ddb387462c7eaf61bb78ad',
        'apns_app' => FactoryGirl.create(:apns_app).id
      }
    end
  end
end
