class BusinessItemsController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:show, :related_items]

  def create
    response = business_item_creator.perform
    if response.successful?
      render_success(response.object)
      _define_cio_callback(response)
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
      @business_item, repository, photos_repository, locale)
  end

  def destroy
    @business_item = repository.find_for_user(current_user, params[:id])
    return head :not_found unless @business_item

    repository.destroy(@business_item)

    render_collection
  end

  def related_items
    similar_products = SimilarBusinessItems.new(repository, params[:id]).perform
    render json: { similar_products: similar_products
                  .map { |sp|  SimilarBusinessItemsPresenter.new(sp) } }
  end

  def prev_item
    prev_item = repository.prev(params[:id])

    render json: { prev_item: prev_item }
  end

  def next_item
    next_item = repository.next(params[:id])

    render json: { next_item: next_item }
  end

  private

  def business_item_data
    {
      business_item: business_item_params,
      photos: photos_params,
      attributes: attributes_params,
      payment_terms: payment_terms_params
    }
  end

  def business_item_parsed_params
    ActionController::Parameters.new(JSON.parse(params["business_item"]))
  end

  def attributes_params
    parse_attributes params[:attributes] || []
  end

  def payment_terms_params
    if params[:payment_terms]
      JSON.parse(params[:payment_terms]).select { |_, v| v }.keys
    else
      []
    end
  end

  def photos_params
    existing_files = JSON.parse(params[:business_item])["photos"] || []
    new_files = params.select do |key, path|
      path.present? && key.to_s.include?("file")
    end.values
    BusinessItem::Photo::Params.new(existing_files, new_files)
  end

  def render_collection
    render json: BusinessItemsCollectionPresenter.new(
      current_user, params[:page], repository, photos_repository, locale)
  end

  def render_success(business_item)
    render json: BusinessItemBasicPresenter.new(business_item)
  end

  def render_error(business_item, attributes, photos)
    render json: {
      business_item: ErrorsPresenter.new(business_item),
      attributes: attributes.map { |attribute| ErrorsPresenter.new(attribute) },
      photos: photos.select { |photo| photo.errors.present? }.map do |photo|
        PhotosErrorPresenter.new(photo.photo, photo)
      end
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
    business_item_parsed_params.permit(
      [:id,
       :name,
       :description,
       :category_id,
       :fob_price,
       :fob_price_currency_id,
       :fob_price_unit_id,
       :port,
       :payment_terms,
       :supply_ability_capacity,
       :supply_ability_unit_id,
       :supply_ability_frequency_id,
       :packaging_details])
  end

  def business_item_creator
    fail NotImplementedError
  end

  def _define_cio_callback(response)
    response_param = { 'response': response, 'user': current_user }
    obj_class = response.object.class.name.downcase
    if obj_class == 'product'
      obj_business_item = response.object.business.products.count
    else
      obj_business_item = response.object.business.services.count
    end

    if obj_business_item < 2
      event = "user_add_first_#{obj_class}"
    else
      event = 'business_item_update'
    end
    CustomerIoService.new(response_param, event)
  end

  private

  def parse_attributes(params)
    JSON.parse(params).map(&:symbolize_keys!)
  end
end
