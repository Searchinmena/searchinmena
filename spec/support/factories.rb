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
      category { User.categories[:seller] }

      association :business
    end
  end

  factory :business do
    sequence(:name) { |n| "Business#{n}" }
    phone { "777-777-777" }
    business_type { Business.business_types[:agent] }
    association :country
    association :user
  end

  factory :product do
    sequence(:name) { |n| "Product#{n}" }
    association :business
    association :category, factory: :product_category
  end

  factory :service do
    sequence(:name) { |n| "Service#{n}" }
    association :business
    association :category, factory: :service_category
  end

  factory :product_photo do
    photo { test_image }
    association :product
  end

  factory :service_photo do
    photo { test_image }
    association :service
  end

  factory :translatable do
    factory :unit, parent: :translatable, class: "Unit" do
    end
    factory :currency, parent: :translatable, class: "Currency" do
    end
    factory :frequency, parent: :translatable, class: "Frequency" do
    end
    factory :payment_term, parent: :translatable, class: "PaymentTerm" do
    end
    factory :country, parent: :translatable, class: "Country" do
    end
    factory :business_type, parent: :translatable, class: "BusinessType" do
    end
    factory :tag, parent: :translatable, class: "Tag" do
      factory :tag_with_translation do
        transient do
          translation { create(:translation) }
        end

        after :create do |tag, evaluator|
          translation = evaluator.translation
          tag.translations << translation
          tag.save
        end
      end
    end
  end

  factory :translation do
    association :translatable
    locale { "en" }
    sequence(:value) { |n| "Value#{n}" }
  end

  factory :category_translation do
    association :category, factory: :product_category
    locale { "en" }
    sequence(:value) { |n| "Value#{n}" }
  end

  factory :category do
    factory :product_category, parent: :category, class: 'ProductCategory' do
    end
    factory :service_category, parent: :category, class: 'ServiceCategory' do
    end
  end
end
