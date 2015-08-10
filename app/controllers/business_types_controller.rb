class BusinessTypesController < TranslatableController
  inject :business_type_repository

  def index
    if params[:business_id]
      collection = repository.for_business_with_translations(
        params[:business_id], params[:locale]
      )
    else
      collection = repository.all_with_translations(params[:locale])
    end
    render json: collection.map { |t| TranslatablePresenter.new(t) }
  end

  private

  def repository
    business_type_repository
  end
end
