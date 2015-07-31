class BusinessItem::Attribute::Creator < BaseCreator
  inject :product_attribute_repository

  attr_accessor :attribute

  def initialize(attribute, attribute_params)
    self.attribute = attribute
    self.validator = AttributeValidator.new(attribute_params)
    self.storing_handler = ::StoringHandler.new(
      attribute, attribute_params, product_attribute_repository, validator)
  end

  def copy_errors
    validator.copy_errors(attribute)
  end

  def object
    attribute
  end
end
