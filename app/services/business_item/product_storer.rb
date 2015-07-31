class BusinessItem::ProductStorer < BusinessItem::Storer
  inject :product_attribute_repository, :product_photo_repository

  def initialize(records, params)
    product_creator = BusinessItem::ProductCreator.new(records[:product],
                                                       params[:business_item])
    attributes_creator = BusinessItem::Attribute::Storer.new(product_attribute_repository,
                                                            params[:attributes],
                                                            records[:product])
    photos_creator = BusinessItem::Photo::Storer.new(product_photo_repository,
                                                            params[:photos],
                                                            records[:product])

    self.handlers = [product_creator, attributes_creator, photos_creator]
  end

end
