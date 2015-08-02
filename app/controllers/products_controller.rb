class ProductsController < BusinessItemsController
  inject :product_repository

  def repository
    product_repository
  end

  def business_item_creator
    BusinessItem::ProductCreator.new(product_params, current_user)
  end

  def business_item_presenter_factory
    ProductPresenter
  end

  def resource_name
    :product
  end

  def product_params
    {
      business_item: business_item_params,
      photos: photos_params,
      attributes: attributes_params
    }
  end

  def business_item_params
    product_specific_params = params.permit(
      [:model_number, :brand_name, :min_order_quantity_number,
       :min_order_quantity_unit_id])
    super.merge(product_specific_params)
  end

  def photos_params
    files = params.select { |key, value| key.to_s.include? "file" }.values
    files.any? ? files : []
  end

  def attributes_params
    JSON.parse(params[:attributes]).map { |attribute| attribute.symbolize_keys! }
  end
end
