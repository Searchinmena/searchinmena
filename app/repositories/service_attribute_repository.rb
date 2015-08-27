class ServiceAttributeRepository < ServiceResourceRepository
  include BusinessItemAttributeRepository

  def for_business_item(business_item)
    business_item.service_attributes
  end
end
