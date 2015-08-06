FactoryGirl.define do
  factory :user do
    sequence(:first_name) { "Alicia" }
    sequence(:last_name) { "Florrick" }
    sequence(:email) { |n| "aliciaflorrick#{n}@gmail.com" }
    password { "voteforalicia" }
    password_confirmation { "voteforalicia" }
    category { User.categories[:buyer] }

    factory :buyer, parent: :user do
    end

    factory :seller, parent: :user do
      category { User.categories[:seller] }

      business { build(:business, user: nil) }

      factory :both, parent: :user do
        category { User.categories[:both] }
      end
    end
  end

  factory :business do
    sequence(:name) { |n| "Business#{n}" }
    phone { "777-777-777" }
    year_registered { 2011 }
    no_of_employees { 123 }
    city { 'Krakow' }
    introduction { 'business introduction' }
    association :country
    association :user

    transient do
      tags { [create(:tag)] }
    end

    transient do
      business_types { [create(:business_type)] }
    end

    after :build do |business, evaluator|
      business.business_types += evaluator.business_types
      business.tags += evaluator.tags
    end
  end

  factory :product do
    sequence(:name) { |n| "Product#{n}" }
    association :business
    association :category, factory: :product_category

    transient do
      photos { [build(:product_photo, product: nil)] }
    end

    before :create do |product, evaluator|
      product.photos += evaluator.photos
    end
  end

  factory :service do
    sequence(:name) { |n| "Service#{n}" }
    association :business
    association :category, factory: :service_category

    transient do
      photos { [build(:service_photo, service: nil)] }
    end

    before :create do |service, evaluator|
      service.photos += evaluator.photos
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

  factory :product_attribute do
    association :product
    sequence(:name) { |n| "attribute#{n}" }
    sequence(:value) { |n| "value#{n}" }
  end

  factory :service_attribute do
    association :service
    sequence(:name) { |n| "attribute#{n}" }
    sequence(:value) { |n| "value#{n}" }
  end

  factory :translatable do
    transient do
      translations { [create(:translation, translatable: nil)] }
    end

    after :create do |translatable, evaluator|
      translatable.translations += evaluator.translations
    end

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
    end
  end

  factory :translation do
    locale { "en" }
    sequence(:value) { |n| "Value#{n}" }
  end

  factory :category_translation do
    category { create(:product_category, category_translations: []) }
    locale { "en" }
    sequence(:value) { |n| "Value#{n}" }
  end

  factory :category do
    factory :product_category, parent: :category, class: "ProductCategory" do
    end
    factory :service_category, parent: :category, class: "ServiceCategory" do
    end

    transient do
      category_translations { [build(:category_translation, category: nil)] }
    end

    before :create do |category, evaluator|
      category.translations += evaluator.category_translations
    end
  end
end
