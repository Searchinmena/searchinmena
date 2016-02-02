class ProductRepository < UserResourceRepository
  include BusinessItemRepository
  include SearchableByNameRepository, SearchableByCategory
end
