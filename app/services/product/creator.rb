class Product::Creator < BaseService
  inject :product_repository, :storer_wrapper

  takes :new_product_params

  def perform
    product = product_repository.new(new_product_params[:product])
    storer = storer_wrapper.create_storer(product, new_product_params[:product])
    storer.perform(product)
  end
end

