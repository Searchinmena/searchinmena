require 'csv'

class CategoriesSeeder
  attr_accessor :type, :repository, :translation_repository

  def initialize(type, repository, translation_repository)
    self.type = type
    self.repository = repository
    self.translation_repository = translation_repository
  end

  def seed
    CSV.foreach(path) do |row|
      row.each_with_index do |name, i|
        next unless name

        parent_category = parent(i, row)
        category_key = key(name)

        category = repository.find_or_create(key: category_key)
        repository.update_parent(category, parent_category)

        locales.each do |locale|
          translation_repository.find_or_create(key: key(name),
                                                locale: locale,
                                                value: name)
        end
      end
    end
  end

  def locales
    %w{en ar}
  end

  def parent(i, row)
    return nil unless i - 1 >= 0

    parent_key = key(row[i - 1])
    repository.find_by_key(parent_key)
  end

  def key(name)
    name.downcase.gsub(" ", "_")
  end

  def path
    Rails.root.join("db", "seeds", "#{type}_categories.csv")
  end
end
