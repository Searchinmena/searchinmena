class RegistrationsController < Devise::RegistrationsController
  inject :user_repository, :business_repository, :business_presenter

  def new
    user = user_repository.new
    business = business_repository.new
    render :new, locals: {
      user: user, business: business,
      business_presenter: business_presenter
    }
  end

  def create
    user_creator = Registration::Creator.new(user_params, business_params)
    response = user_creator.perform
    if response.successful?
      sign_up(:user, response.user)
      head :ok
    else
      render_error(response.user, response.business)
    end
  end

  private

  def render_error(user, business)
    render json: {
      user: ErrorsPresenter.new(user),
      business: ErrorsPresenter.new(business)
    }, status: :conflict
  end

  def user_params
    sign_up_params
  end

  def business_params
    params[:business]
      .permit([:name, :country, :phone, :business_type])
  end
end
