class BusinessItem::Attribute::StoringHandler < BusinessItem::BaseStoringHandler
  attr_reader :product, :handlers

  def initialize(repository, product, attributes_params)
    @product = product
    @attributes_params = attributes_params
    @handlers = attributes_params.map do |attribute|
      new_attribute = repository.new_for_business_item(product, attribute)
      BusinessItem::Attribute::Creator.new(repository, new_attribute, attribute)
    end
  end

  def object
    product
  end
end
