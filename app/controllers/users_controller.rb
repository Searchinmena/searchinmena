class UsersController < ApplicationController
  def show
    render json: UserPresenter.new(current_user)
  end
end
