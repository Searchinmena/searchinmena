class RegistrationsController < Devise::RegistrationsController
  inject :user_repository, :business_repository, :business_presenter

  def new
    user = user_repository.new
    business = business_repository.new
    render_new(user, business)
  end

  def create
    user_creator = Registration::Creator.new(user_params, business_params)
    response = user_creator.perform
    if response.successful?
      sign_up(:user, response.user)
      redirect_to dashboard_path
    else
      render_new(response.user, response.business)
    end
  end

  private

  def render_new(user, business)
    render :new, locals: {
      user: user, business: business,
      business_presenter: business_presenter
    }
  end

  def user_params
    sign_up_params
  end

  def business_params
    params[:user][:business]
      .permit([:name, :country, :phone, :business_type])
  end
end
