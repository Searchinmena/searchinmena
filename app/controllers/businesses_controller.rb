class BusinessesController < ApplicationController
  inject :business_repository

  def create
    business = business_repository.new
    business_creator = Business::Creator.new(business, business_params,
                                             tags_params, locale, current_user)
    response = business_creator.perform
    if response.successful?
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
    params.require(:business).permit(:name, :country_id, :phone,
                                     :year_registered, :no_of_employees,
                                     :introduction, :address_line_1,
                                     :address_line_2, business_type_ids: [])
  end

  def tags_params
    params.permit(tags: [:id, :label])[:tags] || {}
  end
end
