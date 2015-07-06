require 'csv'

class TranslatableSeeder
  def seed
    seeds.each do |seed, repository|
      next if repository.count > 0

      seed_one(seed, repository)
    end
  end

  def seed_one(seed, repository)
    CSV.foreach(path(seed)) do |en_val, ar_val|
      object = repository.new
      object.save

      repository.create_translation(object, en_val, 'en')
      repository.create_translation(object, ar_val, 'ar')
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
      payment_terms: PaymentTermRepository.new,
      countries: CountryRepository.new,
      business_types: BusinessTypeRepository.new,
      tags: TagRepository.new
    }
  end
end

