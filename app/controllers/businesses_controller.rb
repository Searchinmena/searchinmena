class BusinessesController < ApplicationController
  inject :business_repository
  skip_before_filter :authenticate_user!

  def show
    business = business_repository.find_by_id(params[:id])
    if business
      render json: BusinessPresenter.new(business, locale)
    else
      head :not_found
    end
  end
end
