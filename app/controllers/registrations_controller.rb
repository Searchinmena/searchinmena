class RegistrationsController < Devise::RegistrationsController
  inject :user_repository, :business_repository, :business_presenter,
         :user_params_factory

  def new
    user_params = user_params_factory.build(session["devise.auth_data"])
    user = user_repository.new(user_params)
    business = business_repository.new
    session["devise.auth_data"] = nil
    render :new, locals: {
      user: user, business: business,
      user_presenter: UserPresenter.new(user),
      business_presenter: business_presenter
    }
  end

  def create
    user_creator = Registration::Creator.new(registration_params)
    response = user_creator.perform
    if response.successful?
      sign_up(:user, response.user)
      flash[:notice] = t("devise.registrations.signed_up")
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

  def sign_up_params
    params.require(:user).permit([:email, :password, :password_confirmation,
                                  :first_name, :last_name, :category,
                                  :provider, :uid])
  end

  def registration_params
    {
      user: sign_up_params,
      business: business_params,
      tags: tags_params
    }
  end

  def business_params
    params[:business]
      .permit([:name, :country, :phone, :business_type])
  end

  def tags_params
    params.permit(tags: :name)[:tags] || {}
  end
end
