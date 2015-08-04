class BusinessItem::ProductStoringHandler < BaseService
  inject :product_repository, :product_attribute_repository,
         :product_photo_repository, :product_payment_term_repository

  attr_accessor :handlers, :product, :storing_handler,
                :attributes_handler, :photos_handler,
                :payment_terms_handler

  def initialize(product, product_params, attributes_params,
                 payment_terms_params, photos_params)
    self.product = product
    self.storing_handler = product_handler(
      product, product_params, photos_params, product_repository
    )
    self.attributes_handler = BusinessItem::Attribute::StoringHandler.new(
      product_attribute_repository, product, attributes_params
    )
    self.photos_handler = BusinessItem::Photo::StoringHandler.new(
      product_photo_repository, product, photos_params
    )
    self.payment_terms_handler = BusinessItem::PaymentTerms::Creator.new(
      product_payment_term_repository, payment_terms_params, product
    )
    self.handlers = [storing_handler, attributes_handler, photos_handler]
  end

  def perform
    success = if valid?
                handlers.map(&:perform).all?(&:successful?) &&
                payment_terms_handler.perform.successful?
              else
                copy_errors
              end

    BusinessItem::Response.new(success: success,
                               business_item: product,
                               attributes: attributes,
                               photos: photos)
  end

  def valid?
    handlers.map(&:valid?).all?
  end

  def copy_errors
    handlers.map(&:copy_errors)
    false
  end

  def attributes
    attributes_handler.objects
  end

  def photos
    photos_handler.objects
  end

  private

  def product_handler(product, product_params, photos_params, repository)
    validation_params = product_params.merge(photos_count: photos_params.count)
    product_validator = ProductValidator.new(validation_params)
    StoringHandler.new(
      product,
      product_params,
      repository,
      product_validator
    )
  end
end
