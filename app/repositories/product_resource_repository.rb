class ProductResourceRepository < AbstractRepository
  def attributes_with_business_item(attributes, business_item)
    attributes.merge(product: business_item)
  end

  def new_for_business_item(product, attrubute)
    klass.new(attrubute.merge({product: product}))
  end
end
