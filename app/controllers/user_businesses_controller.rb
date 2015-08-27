class UserBusinessesController < ApplicationController
  inject :business_repository, :user_repository, :business_photo_repository

  def show
    business = business_repository.find_by_user_id(current_user.id)
    if business
      render_success(business)
    else
      head :not_found
    end
  end

  def update
    @business = business_repository.find_or_build(user_id: current_user.id)
    photos = photos_storing_handler.photos
    business_saver = Business::Saver.new(handlers, @business, photos)
    response = business_saver.perform
    render_response(response)
  end

  private

  def handlers
    base_business_saver = BaseBusinessSaver.new(@business, business_params,
                                tags_params, logo_params, locale, current_user)
    user_category_service = UserCategoryService.new(user_repository,
                                                    current_user, @business)
    [base_business_saver, photos_storing_handler, user_category_service]
  end

  def photos_storing_handler
    Business::PhotosStoringHandler.new(
      business_photo_repository, @business, photos_params)
  end

  def render_response(response)
    if response.successful?
      render_success(response.object)
    else
      render_error(response.object, response.photos)
    end
  end

  def render_success(business)
    render json: BusinessPresenter.new(business, locale)
  end

  def render_error(business, photos)
    render json: {
      business: ErrorsPresenter.new(business),
      photos: photos.select { |photo| photo.errors.present? }.map do |photo|
        PhotosErrorPresenter.new(photo.photo, photo)
      end
    }, status: :conflict
  end

  def photos_params
    files = params.select { |key, _| key.to_s.include? "file" }.values
    files.any? ? files : []
  end

  def business_params
    parsed_business_params.permit(:name, :country_id, :phone, :year_registered,
                                  :no_of_employees, :introduction, :city,
                                  :address_line_1, :address_line_2,
                                  business_type_ids: [])
  end

  def logo_params
    parsed_business_params.permit(:logo)
  end

  def parsed_business_params
    parsed_params = ActionController::Parameters.new(
      JSON.parse(params[:business])
    )
    parsed_params[:logo] = params[:logo]
    parsed_params
  end

  def tags_params
    params.permit(tags: [:id, :label])[:tags] || {}
  end
end
