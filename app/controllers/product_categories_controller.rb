class ProductCategoriesController < ApplicationController
  inject :product_category_repository

  def index
    categories = product_category_repository.for_parent_id(
      params[:parent_id],
      params[:locale]
    )
    render json: categories.map { |c| CategoryPresenter.new(c) }
  end
end
