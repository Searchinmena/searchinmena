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
    association :country
    association :user

    transient do
      business_types { [create(:business_type)] }
    end

    after(:build) do |business, evaluator|
      business.business_types += evaluator.business_types
    end
  end

  factory :product do
    sequence(:name) { |n| "Product#{n}" }
    association :business
    association :category, factory: :product_category

    before :create do |product|
      product.photos << build(:product_photo, product: nil)
    end
  end

  factory :service do
    sequence(:name) { |n| "Service#{n}" }
    association :business
    association :category, factory: :service_category

    before :create do |service|
      service.photos << build(:service_photo, service: nil)
    end
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
    category { create(:product_category, category_translation: nil) }
    locale { "en" }
    sequence(:value) { |n| "Value#{n}" }
  end

  factory :category do
    factory :product_category, parent: :category, class: 'ProductCategory' do
    end
    factory :service_category, parent: :category, class: 'ServiceCategory' do
    end

    transient do
      category_translation { build(:category_translation, category: nil) }
    end

    before :create do |category, evaluator|
      translation = evaluator.category_translation
      category.translations << translation if translation
    end
  end
end
