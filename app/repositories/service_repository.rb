class ServiceRepository < UserResourceRepository
  include BusinessItemRepository
  include SearchableByNameRepository
end
