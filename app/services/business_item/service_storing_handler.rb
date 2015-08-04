class BusinessItem::ServiceStoringHandler < BaseService
  inject :service_repository, :service_attribute_repository,
         :service_photo_repository, :service_payment_term_repository

  attr_accessor :handlers, :service, :storing_handler, :attributes_handler,
                :photos_handler, :payment_terms_handler

  def initialize(service, service_params, attributes_params,
                 payment_terms_params, photos_params)
    self.service = service
    self.storing_handler = service_handler(
      service,
      service_params,
      photos_params,
      service_repository
    )

    self.attributes_handler = BusinessItem::Attribute::StoringHandler.new(
      service_attribute_repository,
      service,
      attributes_params
    )
    self.photos_handler = BusinessItem::Photo::StoringHandler.new(
      service_photo_repository,
      service,
      photos_params
    )
    self.payment_terms_handler = BusinessItem::PaymentTerms::Creator.new(
      service_payment_term_repository,
      payment_terms_params,
      service
    )
    self.handlers = [storing_handler, attributes_handler, photos_handler]
  end

  def perform
    success = if valid?
                handlers.map(&:perform).all?(&:successful?)
                payment_terms_handler.perform
              else
                copy_errors
              end

    BusinessItem::Response.new(success: success,
                               business_item: service,
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

  def service_handler(service, service_params, photos_params, repository)
    service_validator = ServiceValidator.new(
      service_params.merge(photos_count: photos_params.count)
    )
    StoringHandler.new(
      service,
      service_params,
      repository,
      service_validator
    )
  end
end
