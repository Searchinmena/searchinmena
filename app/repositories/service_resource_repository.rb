class ServiceResourceRepository < AbstractRepository
  def attributes_with_business_item(attributes, business_item)
    attributes.merge(service: business_item)
  end
end
