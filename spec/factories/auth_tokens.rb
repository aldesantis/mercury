# frozen_string_literal: true

FactoryGirl.define do
  factory :auth_token do
    skip_create
    association :profile
  end
end
