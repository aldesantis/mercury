FactoryGirl.define do
  factory :profile_group do
    sequence(:name) { |n| "group-#{n}" }
  end
end
