module Users
  class RegistrationsController < Devise::RegistrationsController
    inject :user_repository, :business_repository, :user_params_factory

    def new
      user_params = user_params_factory.build(session["devise.auth_data"])
      user = user_repository.new(user_params)
      business = business_repository.new
      session["devise.auth_data"] = nil
      render :new, locals: {
        user: user, business: business,
        user_presenter: UserPresenter.new(user)
      }
    end

    def create
      user_creator = Registration::Creator.new(registration_params)
      response = user_creator.perform
      if response.successful?
        sign_up(:user, response.user)
        insightly_create(response.user)
        flash[:notice] = t("devise.registrations.signed_up")
        head :ok
        u = response.user
        CustomerIoService.new(u, 'user_signup')
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
        tags: tags_params,
        locale: locale
      }
    end

    def business_params
      params[:business].permit([:name, :country_id, :phone,
                                business_type_ids: []])
    end

    def tags_params
      params.permit(tags: [:id, :label])[:tags] || {}
    end

    def insightly_create(user)
      if user.seller? || user.both?
        InsightlyCreateWorker.perform_async(user.id)
      end
    end
  end
end
