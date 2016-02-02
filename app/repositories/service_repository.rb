class ServiceRepository < UserResourceRepository
  include BusinessItemRepository
  include SearchableByNameRepository, SearchableByCategory
end
