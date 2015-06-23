class ProductsController < ApplicationController
  inject :product_repository

  def create
    product_creator = Product::Creator.new(new_product_params, user)
    response = product_creator.perform
    if response.successful?
      head :ok
    else
      render_error(response.product)
    end
  end

  private

  def render_error(product)
    render json: {
      product: ErrorsPresenter.new(product)
    }, status: :conflict
  end

  def new_product_params
    {
      product: product_params
    }
  end

  def product_params
    params[:product]
      .permit([:name, :model_number, :brand_name, :description, :category_id,
               :min_order_quantity_number, :min_order_quantity_unit,
               :fob_price, :fob_price_currency, :fob_price_unit, :port,
               :payment_terms, :supply_abbility_capacity,
               :supply_abbility_unit, :upply_abbility_frequency,
               :packaging_details])
  end
end
