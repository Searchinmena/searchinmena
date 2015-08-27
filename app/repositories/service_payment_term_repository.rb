class ServicePaymentTermRepository < ServiceResourceRepository
  include BusinessItemPaymentTermRepository

  def for_business_item(business_item)
    business_item.service_payment_terms
  end
end
