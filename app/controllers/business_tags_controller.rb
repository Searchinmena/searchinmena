class BusinessTagsController < TranslatableController
  inject :business_repository

  def index
    tags = business_repository.tags(params[:business_id])
    render json: tags.map { |t| TranslatablePresenter.new(t) }
  end
end
