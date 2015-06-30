class TranslatableController < ApplicationController
  skip_before_filter :authenticate_user!

  def index
    collection = repository.all_with_translations(params[:locale])
    render json: collection.map { |t| TranslatablePresenter.new(t) }
  end
end
