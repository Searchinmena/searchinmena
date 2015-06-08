class Api::TagsController < Api::BaseController
  inject :tag_repository

  def index
    tags = tag_repository.find_with_query(params[:query])
    render json: tags.map { |t| Api::TagPresenter.new(t) }
  end
end
