class ProductResourceRepository < AbstractRepository
  def attributes_with_business_item(attributes, business_item)
    attributes.merge(product: business_item)
  end

  def new_for_business_item(product, attribute)
    klass.new(attributes_with_business_item(attribute, product))
  end
end
