class SearchController < ApplicationController
  inject :search_service, :autocomplete_search, :result_presenter_factory

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

  def autosuggestion
    response = autocomplete_search.perform(params[:type].to_sym, params)
    render json: AutoSearchPresenter.new(response)
  end
end
