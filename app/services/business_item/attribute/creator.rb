class BusinessItem::Attribute::Creator < ::BaseCreator
  attr_accessor :attribute

  def initialize(repository, attribute, attribute_params)
    self.attribute = attribute
    self.validator = AttributeValidator.new(attribute_params)
    self.storing_handler = ::StoringHandler.new(
      attribute, attribute_params, repository, validator)
  end

  def copy_errors
    validator.copy_errors(attribute)
  end

  def object
    attribute
  end
end
