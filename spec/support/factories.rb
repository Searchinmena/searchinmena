FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.org" }
    password { "testtest" }
    password_confirmation { "testtest" }
  end

  factory :business do
    sequence(:name) { |n| "Business#{n}" }
    country { "ARE" }
    phone { "777-777-777" }
    business_type { Business.business_types[:agent] }
    association :user
  end
end
