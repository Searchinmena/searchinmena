class ProductCategoriesController < CategoriesController
  skip_before_filter :authenticate_user!, only: [:index]
  inject :product_category_repository

  def repository
    product_category_repository
  end
end
