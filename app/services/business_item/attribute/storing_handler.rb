class BusinessItem::Attribute::StoringHandler < BusinessItem::BaseStoringHandler
  attr_accessor :product, :create_handlers, :update_handlers, :repository

  def initialize(repository, product, attributes_params)
    self.repository = repository
    self.product = product

    build_handlers(attributes_params)
  end

  def build_handlers(params)
    to_create = to_create_params(params)
    self.create_handlers = to_create.map do |attribute_params|
      new_attribute = repository.new_for_business_item(product,
                                                       attribute_params)
      BusinessItem::Attribute::Creator.new(repository, new_attribute,
                                           attribute_params)
    end

    to_update = to_update_params(params)
    self.update_handlers = to_update.map do |attribute, attribute_params|
      BusinessItem::Attribute::Creator.new(repository, attribute,
                                           attribute_params)
    end
  end

  def handlers
    create_handlers + update_handlers
  end

  def store
    updated_ids = update_handlers.map { |h| h.attribute.id }
    repository.delete_other_than(product, updated_ids)
    super
  end

  def to_create_params(params)
    params.select { |h| h[:id].blank? }
  end

  def to_update_params(params)
    to_update_ids = params.select { |h| h[:id].present? }
    repository.to_update(product, to_update_ids)
  end

  def object
    product
  end
end
