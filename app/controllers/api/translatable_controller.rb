class Api::TranslatableController < Api::BaseController
  def index
    collection = repository.all_with_translations(params[:locale])
    render json: collection.map { |t| Api::TranslatablePresenter.new(t) }
  end
end
