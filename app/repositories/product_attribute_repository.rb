class ProductAttributeRepository < ProductResourceRepository
  include BusinessItemAttributeRepository

  def for_business_item(business_item)
    business_item.product_attributes
  end
end
