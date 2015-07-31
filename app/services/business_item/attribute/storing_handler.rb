class BusinessItem::Attribute::StoringHandler < BaseService
  inject :product_attribute_repository

  attr_reader :product, :creators

  def initialize(product, attributes_params)
    @product = product
    @attributes_params = attributes_params
    @creators = attributes_params.map do |attribute|
      new_attribute = product_attribute_repository.new_for_product(product, attribute)
      BusinessItem::Attribute::Creator.new(new_attribute, attribute)
    end
  end

  def perform
    success = if valid?
                store
              else
                copy_errors(product)
              end
    Response.new(success: success, object: product)
  end

  def valid?
    creators.map(&:valid?).all?
  end

  def store
    creators.map(&:perform).all?
  end

  def copy_errors
    creators.map(&:copy_errors)
    false
  end

  def objects
    creators.map(&:object)
  end

end
