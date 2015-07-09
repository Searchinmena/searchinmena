class PhotosController < ApplicationController
  def create
    business_item = repository.find_for_user(current_user,
                                             params[:business_item_id])

    file = params[:file]
    response = photo_creator.perform(business_item, file)
    if response.successful?
      head :ok
    else
      render json: PhotosErrorPresenter.new(file, response),
             status: :conflict
    end
  end
end
