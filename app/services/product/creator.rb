class Product::Creator < BaseService
  inject :product_repository

  takes :new_product_params

  def perform
    product = product_repository.new(new_product_params[:product])
    storer.perform(product)
  end
end

