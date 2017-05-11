# frozen_string_literal: true

FactoryGirl.define do
  factory :device do
    association :profile
    type { Device.type.values.sample }
    source { { 'udid' => SecureRandom.uuid } }
  end
end
