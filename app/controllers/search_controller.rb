class SearchController < ApplicationController
  inject :search_service
  skip_before_action :authenticate_user!

  def create
    response = search_service.perform(params[:search])
    if response.successful?
      render json: response.results
    else
      render json: response.errors, status: :conflict
    end
  end
end
