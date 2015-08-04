class BusinessItem::Attribute::StoringHandler < ::BaseService
  attr_reader :product, :creators

  def initialize(repository, product, attributes_params)
    @product = product
    @attributes_params = attributes_params
    @creators = attributes_params.map do |attribute|
      new_attribute = repository.new_for_business_item(product, attribute)
      BusinessItem::Attribute::Creator.new(repository, new_attribute, attribute)
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
