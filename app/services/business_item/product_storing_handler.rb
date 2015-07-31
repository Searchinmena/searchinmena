class BusinessItem::ProductStoringHandler < BaseService
  inject :product_repository

  attr_accessor :handlers, :product, :storing_handler, :attributes_storing_handler, :photos_storing_handler

  def initialize(product, product_params, attributes_params, photos_params)
    self.product = product
    product_validator = ProductValidator.new(product_params.merge(photos_count: photos_params.count))
    self.storing_handler = StoringHandler.new(product, product_params,
                                              product_repository, product_validator)

    self.attributes_storing_handler = BusinessItem::Attribute::StoringHandler.new(product,
                                                                                  attributes_params)
    self.photos_storing_handler = BusinessItem::Photo::StoringHandler.new(product,
                                                                          photos_params)
    self.handlers = [storing_handler, attributes_storing_handler, photos_storing_handler]
  end

  def perform
    success = if valid?
                handlers.map(&:perform).all?(&:successful?)
              else
                copy_errors
              end

    BusinessItem::Response.new(success: success, product: product, attributes: attributes, photos: photos)
  end

  def valid?
    handlers.map(&:valid?).all?
  end

  def copy_errors
    handlers.map(&:copy_errors)
    false
  end

  def prepare_attribites_objects(params)
    params.map do |attribute|
      product_attribute_repository.new_for_product(product, attribute)
    end
  end

  def attributes
    attributes_storing_handler.objects
  end

  def photos
    photos_storing_handler.objects
  end
end
