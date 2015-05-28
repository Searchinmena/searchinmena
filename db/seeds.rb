categories_path = Rails.root.join("db", "seeds", "tags.txt")
tag_repository = TagRepository.new

File.open(categories_path).each_line do |name|
  tag_repository.find_or_create(name: name.strip)
end

