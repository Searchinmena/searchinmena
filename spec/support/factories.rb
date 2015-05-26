FactoryGirl.define do
  factory :business do
    sequence(:name) { |n| "Business#{n}" }
    country { "ARE" }
    phone { "777-777-777" }
    business_type { Business.types[:agent] }
  end
end
