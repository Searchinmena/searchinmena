class ProductCategoriesController < CategoriesController
  inject :product_category_repository

  def repository
    product_category_repository
  end
end
