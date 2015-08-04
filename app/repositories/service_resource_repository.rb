class ServiceResourceRepository < AbstractRepository
  def attributes_with_business_item(attributes, business_item)
    attributes.merge(service: business_item)
  end

  def new_for_business_item(service, attrubute)
    klass.new(attrubute.merge(service: service))
  end
end
