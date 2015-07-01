class Api::ProductPresenter
  takes :product

  def as_json(*)
    {
      name: product.name,
      model_number: product.model_number,
      brand_name: product.brand_name,
      description: product.description,
      trad_info: trad_info_json
    }
  end

  def trad_info_json
    {
      min_order_quantity: min_order_quantity_json,
      fob: fob_json,
      port: product.port,
      payment_terms: product.payment_terms,
      supply_ability_number: product.supply_ability_number,
      supply_ability_type: product.supply_ability_type,
      upply_ability_capacity: product.upply_ability_capacity,
      packaging_details: product.packaging_details
    }
  end

  def min_order_quantity_json
    {
      min_order_quantity_number: product.min_order_quantity_number,
      min_order_quantity_unit: product.min_order_quantity_unit
    }
  end

  def fob_json
    {
      fob_price: product.FOB_price,
      fob_price_type: product.FOB_price_type,
      fob_price_unit: product.FOB_price_unit
    }
  end
end
