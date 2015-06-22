class TagsController < ApplicationController
  inject :tag_repository

  def index
    tags = tag_repository.find_with_query(params[:query])
    render json: tags.map { |t| TagPresenter.new(t) }
  end
end
