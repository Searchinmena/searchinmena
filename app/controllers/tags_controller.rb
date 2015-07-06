class TagsController < ApplicationController
  skip_before_filter :authenticate_user!

  inject :tag_repository

  def index
    tags = tag_repository.find_with_query(params[:query], locale)
    render json: tags.map { |t| TranslatablePresenter.new(t) }
  end
end
