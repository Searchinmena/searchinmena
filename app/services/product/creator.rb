class Product::Creator < BaseService
  inject :product_repository, :storer_wrapper, :business_repository

  takes :params, :user

  def perform
    business = business_repository.find_by_user_id(user.id)
    return unless business.present?

    product_params = params[:product]
    product = product_repository.new(product_params)
    validator = ProductValidator.new(product_params)
    storing_handler = StoringHandler.new(product, product_params,
                                         product_repository, validator)

    storing_handler.perform
  end
end

