class ServiceRepository < UserResourceRepository
  include BusinessItemRepository
  include SearchableByNameRepository, SearchableByCategory

  def find_similar(category, object_id)
    klass.where(category: category).where.not(id: object_id).first(6)
  end
end
