class BusinessItem::ServiceStoringHandler <
  BusinessItem::BusinessItemStoringHandler

  inject :service_repository, :service_attribute_repository,
         :service_photo_repository, :service_payment_term_repository

  def business_item_repository
    service_repository
  end

  def business_item_validator
    ServiceValidator
  end

  def attribute_repository
    service_attribute_repository
  end

  def photo_repository
    service_photo_repository
  end

  def payment_term_repository
    service_payment_term_repository
  end
end
