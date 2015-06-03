class RegistrationsController < Devise::RegistrationsController
  inject :user_repository, :business_repository, :business_presenter,
         :user_params_factory

  def new
    user_params = user_params_factory.build(session["devise.auth_data"])
    user = user_repository.new(user_params)
    business = business_repository.new
    session["devise.auth_data"] = nil
    render_new(user, business)
  end

  def create
    user_creator = Registration::Creator.new(sign_up_params, business_params)
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

  def sign_up_params
    params.require(:user).permit([:email, :password, :password_confirmation,
                                  :first_name, :last_name, :category,
                                  :provider, :uid])
  end

  def business_params
    params[:user][:business]
      .permit([:name, :country, :phone, :business_type])
  end
end
