class TranslatableController < ApplicationController
  def index
    collection = repository.all_with_translations(params[:locale])
    render json: collection.map { |t| TranslatablePresenter.new(t) }
  end
end
