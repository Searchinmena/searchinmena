require 'csv'

categories_path = Rails.root.join("db", "seeds", "tags.txt")
tag_repository = TagRepository.new

File.open(categories_path).each_line do |name|
  tag_repository.find_or_create(name: name.strip)
end

translation_repository = TranslationRepository.new

def seed_from_csv(seed, repository, translation_repository)
  path = Rails.root.join("db", "seeds", "#{seed}.csv")

  CSV.foreach(path) do |key, en_val, ar_val|
    repository.find_or_create(key: key)
    translation_repository.find_or_create(key: key, locale: 'en', value: en_val)
    translation_repository.find_or_create(key: key, locale: 'ar', value: ar_val)
  end
end

seeds = {
  units: UnitRepository.new,
  currencies: CurrencyRepository.new,
  frequencies: FrequencyRepository.new,
  payment_terms: PaymentTermRepository.new
}

seeds.each do |seed, repository|
  seed_from_csv(seed, repository, translation_repository)
end

# user for e2e tests
require 'factory_girl'
require './spec/support/factories'
unless User.where(email: TEST_EMAIL).count > 0
  FactoryGirl.create(:user, email: TEST_EMAIL, password: TEST_PASSWORD)
end
