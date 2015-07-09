class BusinessItem::ServiceAttributesCreator < BaseService
  inject :service_attribute_repository

  takes :params, :business_item

  def perform
    creator = BusinessItem::AttributesCreator.new(
      service_attribute_repository, params, business_item)
    creator.perform
  end
end
