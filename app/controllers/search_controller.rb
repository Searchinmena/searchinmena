class SearchController < ApplicationController
  inject :search_service, :result_presenter_factory

  skip_before_action :authenticate_user!

  def index
    type = params[:type]
    response = search_service.perform(type, params[:query])
    if response.successful?
      render json: response.results
        .map { |result| result_presenter_factory.build(result, type, locale) }
    else
      head :conflict
    end
  end
end
