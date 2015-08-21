class ProductRepository < UserResourceRepository
  include BusinessItemRepository
  include SearchableByNameRepository
end
