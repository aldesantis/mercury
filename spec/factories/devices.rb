# frozen_string_literal: true

FactoryGirl.define do
  factory :device do
    association :profile
    type { Device.type.values.sample }
    source do
      {
        'udid' => SecureRandom.uuid,
        'apns_app' => FactoryGirl.create(:apns_app).id
      }
    end
  end
end
