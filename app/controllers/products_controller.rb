class ProductsController < BusinessItemsController
  inject :product_repository

  def repository
    product_repository
  end

  def business_item_creator
    BusinessItem::ProductCreator.new(new_business_item_params, current_user)
  end

  def business_item_presenter_factory
    ProductPresenter
  end

  def resource_name
    :product
  end

  def business_item_params
    product_specific_params = params[resource_name].permit(
      [:model_number, :brand_name, :min_order_quantity_number,
       :min_order_quantity_unit_id])
    super.merge(product_specific_params)
  end
end
