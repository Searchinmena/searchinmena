class BusinessesController < ApplicationController
  inject :business_repository

  def show
    business = business_repository.find_by_user_id(current_user.id)
    if business
      render_success(business)
    else
      head :not_found
    end
  end

  def update
    business = business_repository.find_or_build(user_id: current_user.id)
    business_saver = Business::Saver.new(business, business_params,
                                         tags_params, locale, current_user)
    response = business_saver.perform
    if response.successful?
      ensure_proper_user_type
      render_success(response.object)
    else
      render_error(response.object)
    end
  end

  private

  def render_success(business)
    render json: BusinessPresenter.new(business)
  end

  def render_error(business)
    render json: {
      business: ErrorsPresenter.new(business)
    }, status: :conflict
  end

  def business_params
    params[:business].permit(:name, :country_id, :phone, :year_registered,
                             :no_of_employees, :introduction, :address_line_1,
                             :address_line_2, business_type_ids: [])
  end

  def tags_params
    params.permit(:tags).permit(:id, :label) || {}
  end

  def ensure_proper_user_type
    if current_user.buyer?
      current_user.category = :both
      current_user.save
    end
  end
end
