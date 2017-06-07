# frozen_string_literal: true

FactoryGirl.define do
  factory :notification do
    association :recipient, factory: :profile_group
    text { Faker::Lorem.sentence }
    meta { {} }
    transports { {} }

    trait :apns do
      transient do
        apns_app { FactoryGirl.create(:apns_app) }
      end

      transports do
        {
          'apns' => {
            'apns_app' => apns_app.id
          }
        }
      end
    end
  end
end
