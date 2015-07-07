class ProductResourceRepository < AbstractRepository
  def attributes_with_business_item(attributes, business_item)
    attributes.merge(product: business_item)
  end
end
