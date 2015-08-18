class SearchController < ApplicationController
  inject :search_service
  skip_before_action :authenticate_user!

  def index
    response = search_service.perform(params[:type], params[:query])
    if response.successful?
      render json: response.results
    else
      head :conflict
    end
  end
end
