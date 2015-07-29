class ProductPresenter < BusinessItemPresenter
  def as_json(*)
    super.merge(
      model_number: business_item.model_number,
      brand_name: business_item.brand_name,
      min_order_quantity_number: business_item.min_order_quantity_number,
      min_order_quantity_unit: min_order_quantity_unit
    )
  end

  private

  def min_order_quantity_unit
    translatable_repository.translation_for(
      business_item.min_order_quantity_unit, locale)
  end

  def attributes_collection
    business_item.product_attributes
  end
end
