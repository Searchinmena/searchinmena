class SearchController < ApplicationController
  inject :search_service, :result_presenter_factory

  skip_before_action :authenticate_user!

  def index
    response = search_service.perform(params[:type], params)
    if response.successful?
      render json: SearchResultsPresenter.new(result_presenter_factory,
                                              response.results,
                                              params[:page],
                                              locale)
    else
      head :conflict
    end
  end
end
