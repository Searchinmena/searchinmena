class CategoriesController < ApplicationController
  def index
    categories = repository.for_parent_id(
      params[:parent_id],
      params[:locale]
    )
    render json: categories.map { |c| CategoryPresenter.new(c) }
  end
end
