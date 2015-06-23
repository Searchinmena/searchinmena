class Product::Creator < BaseService
  inject :business_repository, :product_repository

  takes :params, :user

  def perform
    business = business_repository.find_by_user_id(user.id)
    return Response.new(success: false) unless business.present?

    product_params = params[:product].merge(business: business)
    product = product_repository.new(product_params)
    validator = ProductValidator.new(product_params)
    storing_handler = StoringHandler.new(product, product_params,
                                         product_repository, validator)

    storing_handler.perform
  end
end

