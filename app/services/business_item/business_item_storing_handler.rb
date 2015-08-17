class BusinessItem::BusinessItemStoringHandler <
  BusinessItem::BaseStoringHandler

  attr_accessor :handlers, :business_item, :storing_handler,
                :attributes_handler, :photos_handler,
                :payment_terms_handler

  def initialize(business_item, business_item_params, attributes_params,
                 payment_terms_params, photos_params)
    self.business_item = business_item
    self.storing_handler = business_item_handler(
      business_item,
      business_item_params,
      photos_params,
      business_item_repository
    )

    self.attributes_handler = BusinessItem::Attribute::StoringHandler.new(
      attribute_repository,
      business_item,
      attributes_params
    )
    self.photos_handler = BusinessItem::Photo::StoringHandler.new(
      photo_repository,
      business_item,
      photos_params
    )
    self.payment_terms_handler = BusinessItem::PaymentTerms::StoringHandler.new(
      payment_term_repository,
      payment_terms_params,
      business_item
    )
    self.handlers = [storing_handler, attributes_handler, photos_handler,
                     payment_terms_handler]
  end

  def response(success)
    BusinessItem::Response.new(success: success,
                               business_item: business_item,
                               attributes: attributes,
                               photos: photos)
  end

  def attributes
    attributes_handler.objects
  end

  def photos
    photos_handler.objects
  end

  private

  def business_item_handler(business_item, business_item_params,
                            photos_params, repository)
    validator = business_item_validator.new(
      business_item_params.merge(photos_count: photos_params.count)
    )
    StoringHandler.new(
      business_item,
      business_item_params,
      repository,
      validator
    )
  end
end
