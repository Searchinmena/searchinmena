class BusinessItem::ProductAttributesCreator < BaseService
  inject :product_attribute_repository

  takes :params, :business_item

  def perform
    creator = BusinessItem::AttributesCreator.new(
      product_attribute_repository, params, business_item)
    creator.perform
  end
end
