require 'csv'

class CategoriesSeeder
  attr_accessor :type, :repository, :en_csv, :ar_csv

  def initialize(type, repository)
    self.type = type
    self.repository = repository
    self.en_csv, self.ar_csv = %w{en ar}.map do |locale|
      CSV.read(path(locale))
    end
  end

  def seed
    return if repository.count > 0
    fail "en and ar rows don't match" unless rows_match?

    en_csv.count.times do |row_i|
      seed_row(row_i)
    end
  end

  def seed_row(row_i)
    fail "en and ar #{row_i + 1} row cols don't match" unless cols_match?(row_i)

    en_csv[row_i].count.times do |col_i|
      next unless values_present?(row_i, col_i)

      parent_category = parent(row_i, col_i)
      category = find_or_create(row_i, col_i)

      repository.update_parent(category, parent_category)
    end
  end

  def rows_match?
    en_csv.count == ar_csv.count
  end

  def cols_match?(row_i)
    en_csv[row_i].count == ar_csv[row_i].count
  end

  def values_present?(row_i, col_i)
    en_val = en_csv[row_i][col_i]
    ar_val = ar_csv[row_i][col_i]

    en_val.present? && ar_val.present?
  end

  def find_or_create(row_i, col_i)
    en_val = en_csv[row_i][col_i]
    ar_val = ar_csv[row_i][col_i]

    category = repository.find_by_translation(en_val, 'en')

    unless category
      category = repository.new
      category.save

      repository.create_translation(category, en_val, 'en')
      repository.create_translation(category, ar_val, 'ar')
    end

    category
  end

  def parent(row_i, col_i)
    return nil unless col_i - 1 >= 0

    parent_val = en_csv[row_i][col_i - 1]
    repository.find_by_translation(parent_val, 'en')
  end

  def path(locale)
    Rails.root.join("db", "seeds", "#{type}_categories.#{locale}.csv")
  end
end
