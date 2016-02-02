class ServiceCategoriesController < CategoriesController
  skip_before_filter :authenticate_user!, only: [:index]
  inject :service_category_repository

  def repository
    service_category_repository
  end
end
