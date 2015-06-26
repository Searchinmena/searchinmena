translation_repository = TranslationRepository.new
tag_repository = TagRepository.new
categories_repository = CategoryRepository.new

CategoriesSeeder.new(:product, categories_repository,
                     translation_repository).seed
TranslatableSeeder.new(translation_repository).seed
TagsSeeder.new(tag_repository).seed

# user for e2e tests
TestUsersSeeder.new.seed
