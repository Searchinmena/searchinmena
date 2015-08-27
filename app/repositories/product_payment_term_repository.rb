class ProductPaymentTermRepository < ProductResourceRepository
  include BusinessItemPaymentTermRepository

  def for_business_item(business_item)
    business_item.product_payment_terms
  end
end
