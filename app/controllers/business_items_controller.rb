class BusinessItemsController < ApplicationController
  def create
    response = business_item_creator.perform
    if response.successful?
      render_success(response.object)
    else
      render_error(response.object)
    end
  end

  private

  def render_success(business_item)
    render json: BusinessItemPresenter.new(business_item)
  end

  def render_error(business_item)
    render json: {
      business_item: ErrorsPresenter.new(business_item)
    }, status: :conflict
  end

  def new_business_item_params
    {
      business_item: business_item_params,
      attributes: attributes_params
    }
  end

  def business_item_params
    params[:business_item]
      .permit([:name, :description, :category_id,
               :fob_price, :fob_price_currency_id, :fob_price_unit_id, :port,
               :payment_terms, :supply_ability_capacity,
               :supply_ability_unit_id, :supply_ability_frequency_id,
               :packaging_details])
  end

  def business_item_creator
    fail NotImplementedError
  end

  def attributes_params
    params.permit(attributes: [:name, :value])[:attributes] || {}
  end
end
