# frozen_string_literal: true

FactoryGirl.define do
  factory :membership do
    association :profile
    association :profile_group
  end
end
