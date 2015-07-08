class ServiceCategoriesController < CategoriesController
  inject :service_category_repository

  def repository
    service_category_repository
  end
end
