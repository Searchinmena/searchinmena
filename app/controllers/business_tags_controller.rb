class BusinessTagsController < TranslatableController
  inject :tag_repository

  def index
    tags = tag_repository.for_business_with_translations(
      params[:business_id], params[:locale]
    )
    render json: tags.map { |t| TranslatablePresenter.new(t) }
  end
end
