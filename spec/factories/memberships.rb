# frozen_string_literal: true

FactoryBot.define do
  factory :membership do
    association :profile
    association :profile_group
  end
end
