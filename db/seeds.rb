categories_path = Rails.root.join("db", "seeds", "tags.txt")
tag_repository = TagRepository.new

File.open(categories_path).each_line do |name|
  tag_repository.find_or_create(name: name.strip)
end

# user for e2e tests
require 'factory_girl'
require './spec/support/factories'
unless User.where(email: TEST_EMAIL).count > 0
  FactoryGirl.create(:user, email: TEST_EMAIL, password: TEST_PASSWORD)
end
