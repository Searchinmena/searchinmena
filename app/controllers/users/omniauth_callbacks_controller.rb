module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    inject :user_repository

    def facebook
      set_omniauth_locale
      user = user_repository.find_by_omniauth(request.env["omniauth.auth"])
      if user_exists?(user)
        sign_in_and_redirect(user)
        set_flash_message(:notice, :success, kind: "Facebook") if
        is_navigational_format?
      else
        store_hash_and_redirect(request.env["omniauth.auth"])
      end
    end

    private

    def user_exists?(user)
      user && user.persisted?
    end

    def set_omniauth_locale
      I18n.locale = session[:omniauth_locale] || I18n.default_locale
    end

    def sign_in_and_redirect(user)
      sign_in(user, event: :authentication)
      redirect_to Sim::Routes.dashboard_path
    end

    def store_hash_and_redirect(hash)
      session["devise.auth_data"] = hash
      redirect_to new_user_registration_url
    end
  end
end
