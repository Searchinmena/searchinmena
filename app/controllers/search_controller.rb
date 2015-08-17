class SearchController < ApplicationController
  def create
    render json: params
  end
end
