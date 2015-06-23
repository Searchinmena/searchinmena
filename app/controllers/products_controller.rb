class ProductsController < ApplicationController
  inject :product_repository

  def create
    product_creator = Product::Creator.new(new_product_params)
    response = product_creator.perform
    if response.successful?
      flash[:notice] = t("en.product.added")
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
      product: product_params,
      trade_info: trade_info_params
    }
  end

  def product_params
    params[:product]
      .permit([:name, :model_number, :brand_name, :description, :category])
  end

  def trade_info_params
    params[:product]
      .permit([:min_order_quantity_number, :min_order_quantity_unit,
               :fob_price, :fob_price_type, :fob_price_unit, :port,
               :payment_terms, :supply_abbility_number,
               :supply_abbility_type, :upply_abbility_capacity,
               :packaging_details])
  end
end
