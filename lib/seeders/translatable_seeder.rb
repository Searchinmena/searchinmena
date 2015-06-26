require 'csv'

class TranslatableSeeder
  attr_accessor :translation_repository

  def initialize(translation_repository)
    self.translation_repository = translation_repository
  end

  def seed
    seeds.each do |seed, repository|
      seed_one(seed, repository)
    end
  end

  def seed_one(seed, repository)
    CSV.foreach(path(seed)) do |key, en_val, ar_val|
      repository.find_or_create(key: key)
      translation_repository.find_or_create(key: key,
                                            locale: 'en',
                                            value: en_val)
      translation_repository.find_or_create(key: key,
                                            locale: 'ar',
                                            value: ar_val)
    end
  end

  def path(seed)
    Rails.root.join("db", "seeds", "#{seed}.csv")
  end

  def seeds
    {
      units: UnitRepository.new,
      currencies: CurrencyRepository.new,
      frequencies: FrequencyRepository.new,
      payment_terms: PaymentTermRepository.new
    }
  end
end

