TEST_EMAIL = "test@example.org"
TEST_PASSWORD = "testtest"

FactoryGirl.define do
  factory :user do
    sequence(:first_name) { "Alicia" }
    sequence(:last_name) { "Florrick" }
    sequence(:email) { |n| "aliciaflorrick#{n}@gmail.com" }
    password { "voteforalicia" }
    password_confirmation { "voteforalicia" }
    category { User.categories[:buyer] }

    factory :seller, parent: :user do
      category { User.categories[:buyer] }

      association :business
    end
  end

  factory :business do
    sequence(:name) { |n| "Business#{n}" }
    country { "ARE" }
    phone { "777-777-777" }
    business_type { Business.business_types[:agent] }
    association :user
  end

  factory :product do
    sequence(:name) { |n| "Product#{n}" }
    association :business
  end

  factory :product_photo do
    photo { test_image }
    association :product
  end

  factory :tag do
    sequence(:name) { |n| "Tag#{n}" }
  end

  factory :translatable do
    sequence(:key) { |n| "Key#{n}" }

    factory :unit, parent: :translatable, class: 'Unit' do
    end
    factory :currency, parent: :translatable, class: 'Currency' do
    end
    factory :frequency, parent: :translatable, class: 'Frequency' do
    end
    factory :payment_term, parent: :translatable, class: 'PaymentTerm' do
    end
  end

  factory :translation do
    locale { "en" }
    sequence(:key) { |n| "Key#{n}" }
    sequence(:value) { |n| "Value#{n}" }
  end
end
