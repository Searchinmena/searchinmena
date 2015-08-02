class BusinessItemsController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:show]

  def create
    response = business_item_creator.perform
    if response.successful?
      render_success(response.object)
    else
      render_error(response.object, response.attributes, response.photos)
    end
  end

  def index
    render_collection
  end

  def show
    @business_item = repository.find_by_id(params[:id])
    return head :not_found unless @business_item

    render json: business_item_presenter_factory.new(
      @business_item, repository, locale)
  end

  def destroy
    @business_item = repository.find_for_user(current_user, params[:id])
    return head :not_found unless @business_item

    repository.destroy(@business_item)

    render_collection
  end

  private

  def business_item_parsed_params
    ActionController::Parameters.new(JSON.parse(params["business_item"]))
  end

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

  def render_error(business_item, attributes, photos)
    render json: {
      business_item: ErrorsPresenter.new(business_item),
      attributes: attributes.map { |attribute| ErrorsPresenter.new(attribute) },
      photos: photos.map { |photo| PhotosErrorPresenter.new(photo.photo, photo) },
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
    business_item_parsed_params.permit([:name, :description, :category_id,
               :fob_price, :fob_price_currency_id, :fob_price_unit_id, :port,
               :payment_terms, :supply_ability_capacity,
               :supply_ability_unit_id, :supply_ability_frequency_id,
               :packaging_details])
  end

  def business_item_creator
    fail NotImplementedError
  end

  def attributes_params
    params[:attributes] || []
  end

  def payment_terms_params
    params[:payment_terms] ? params[:payment_terms].keys : []
  end
end
