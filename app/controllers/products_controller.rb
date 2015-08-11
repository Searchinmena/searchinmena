class ProductsController < BusinessItemsController
  inject :product_repository, :product_photo_repository

  def repository
    product_repository
  end

  def photos_repository
    product_photo_repository
  end

  def business_item_creator
    BusinessItem::ProductCreator.new(business_item_data, current_user)
  end

  def business_item_presenter_factory
    ProductPresenter
  end

  def resource_name
    :product
  end

  def business_item_params
    product_specific_params = business_item_parsed_params.permit(
      [:model_number, :brand_name, :min_order_quantity_number,
       :min_order_quantity_unit_id])
    super.merge(product_specific_params)
  end
end
