translation_repository = TranslationRepository.new
tag_repository = TagRepository.new
product_category_repository = ProductCategoryRepository.new

CategoriesSeeder.new(:product, product_category_repository,
                     translation_repository).seed
TranslatableSeeder.new(translation_repository).seed
TagsSeeder.new(tag_repository).seed

# user for e2e tests
TestUsersSeeder.new.seed
