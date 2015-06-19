class ProductPhotosController < ApplicationController
  inject :product_repository, :product_photo_creator

  def create
    product = product_repository.find_for_user(current_user,
                                               params[:product_id])

    response = product_photo_creator.perform(product, params[:file])
    if response.successful?
      head :ok
    else
      render json: response.errors, status: :conflict
    end
  end
end
