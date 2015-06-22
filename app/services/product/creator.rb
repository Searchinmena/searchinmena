class Product::Creator < BaseService
  inject :product_repository, :storer_wrapper, :business_repository

  takes :new_product_params, :user

  def perform
    business = business_repository.find_by_user_id(user.id)
    if business.present?
      product = product_repository.new(new_product_params[:product])
      storer = storer_wrapper.create_storer(product, new_product_params[:product])
      storer.perform(product)
    end
  end
end

