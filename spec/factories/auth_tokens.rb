# frozen_string_literal: true

FactoryBot.define do
  factory :auth_token do
    skip_create
    association :profile
  end
end
