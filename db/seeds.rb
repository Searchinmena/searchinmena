product_category_repository = ProductCategoryRepository.new

CategoriesSeeder.new(:product, product_category_repository).seed
TranslatableSeeder.new.seed

# user for e2e tests
TestUsersSeeder.new.seed
