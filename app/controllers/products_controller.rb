class ProductsController < ApplicationController
  inject :product_repository

  def create
    product_creator = Product::Creator.new(new_product_params, current_user)
    response = product_creator.perform
    if response.successful?
      render_success(response.object)
    else
      render_error(response.object)
    end
  end

  private

  def render_success(product)
    render json: ProductPresenter.new(product)
  end

  def render_error(product)
    render json: {
      product: ErrorsPresenter.new(product)
    }, status: :conflict
  end

  def new_product_params
    {
      product: product_params,
      attributes: attributes_params
    }
  end

  def product_params
    params[:product]
      .permit([:name, :model_number, :brand_name, :description, :category_id,
               :min_order_quantity_number, :min_order_quantity_unit,
               :fob_price, :fob_price_currency, :fob_price_unit, :port,
               :payment_terms, :supply_ability_capacity,
               :supply_ability_unit, :upply_ability_frequency,
               :packaging_details])
  end

  def attributes_params
    params.permit(attributes: [:name, :value])[:attributes] || {}
  end
end
