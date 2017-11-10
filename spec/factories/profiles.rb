# frozen_string_literal: true

FactoryBot.define do
  factory :profile do
    sequence(:name) { |n| "Profile #{n}" }
  end
end
