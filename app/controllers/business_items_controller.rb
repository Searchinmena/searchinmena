class BusinessItemsController < ApplicationController
  before_action :assign_business_item, only: [:show, :destroy]

  def create
    response = business_item_creator.perform
    if response.successful?
      render_success(response.object)
    else
      render_error(response.object)
    end
  end

  def index
    render_collection
  end

  def show
    render json: business_item_presenter_factory.new(
      @business_item, repository, locale)
  end

  def destroy
    repository.destroy(@business_item)

    render_collection
  end

  private

  def assign_business_item
    @business_item = repository.find_for_user(current_user, params[:id])
    head :not_found unless @business_item
  end

  def render_collection
    render json: BusinessItemsCollectionPresenter.new(
      current_user, params[:page], repository, locale)
  end

  def render_success(business_item)
    render json: BusinessItemBasicPresenter.new(business_item)
  end

  def render_error(business_item)
    render json: {
      business_item: ErrorsPresenter.new(business_item)
    }, status: :conflict
  end

  def new_business_item_params
    {
      business_item: business_item_params,
      attributes: attributes_params,
      payment_terms: payment_terms_params
    }
  end

  def business_item_params
    params[resource_name]
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
    params[:breadcrumbs] || []
  end

  def payment_terms_params
    params[:payment_terms] ? params[:payment_terms].keys : []
  end
end
