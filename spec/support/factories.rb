FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "aliciaflorrick#{n}@gmail.com" }
    password { "voteforalicia" }
    password_confirmation { "voteforalicia" }
    category { User.categories[:seller] }
  end

  factory :business do
    sequence(:name) { |n| "Business#{n}" }
    country { "ARE" }
    phone { "777-777-777" }
    business_type { Business.business_types[:agent] }
    association :user
  end
end
