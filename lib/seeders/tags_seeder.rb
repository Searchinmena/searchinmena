class TagsSeeder
  attr_accessor :repository

  def initialize(repository)
    self.repository = repository
  end

  def seed
    File.open(path).each_line do |name|
      repository.find_or_create(name: name.strip)
    end
  end

  def path
    Rails.root.join("db", "seeds", "tags.txt")
  end
end

