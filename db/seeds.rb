product_category_repository = ProductCategoryRepository.new
service_category_repository = ServiceCategoryRepository.new

CategoriesSeeder.new(:product, product_category_repository).seed
CategoriesSeeder.new(:service, service_category_repository).seed
TranslatableSeeder.new.seed

# user for e2e tests
TestUsersSeeder.new.seed
AdminUser.create!(email: 'admin@example.com', password: 'password',
                  password_confirmation: 'password')