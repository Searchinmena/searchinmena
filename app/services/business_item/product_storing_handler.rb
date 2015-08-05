class BusinessItem::ProductStoringHandler <
  BusinessItem::BusinessItemStoringHandler

  inject :product_repository, :product_attribute_repository,
         :product_photo_repository, :product_payment_term_repository

  def business_item_repository
    product_repository
  end

  def business_item_validator
    ProductValidator
  end

  def attribute_repository
    product_attribute_repository
  end

  def photo_repository
    product_photo_repository
  end

  def payment_term_repository
    product_payment_term_repository
  end
end
