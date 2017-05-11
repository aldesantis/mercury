# frozen_string_literal: true

FactoryGirl.define do
  factory :notification do
    association :recipient, factory: :profile_group
    text { Faker::Lorem.sentence }
    meta { {} }
    transports { [Mercury::Notification::Deliver.skills['transports.map'].keys.sample] }
  end
end
