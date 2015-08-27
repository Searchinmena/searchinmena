class BusinessItem::Attribute::StoringHandler < BusinessItem::BaseStoringHandler
  attr_reader :product, :handlers, :repository

  def initialize(repository, product, attributes_params)
    @repository = repository
    @product = product
    @attributes_params = attributes_params
    to_create = to_create(attributes_params)
    @handlers = to_create.map do |attribute|
      new_attribute = repository.new_for_business_item(product, attribute)
      BusinessItem::Attribute::Creator.new(repository, new_attribute, attribute)
    end
  end

  def to_create(params)
    to_update = params.select { |h| h[:id].present? }
    updated_ids = repository.update_for_business_item(product, to_update)
    repository.delete_other_than(product, updated_ids)
    params.select { |h| h[:id].blank? }
  end

  def object
    product
  end
end
