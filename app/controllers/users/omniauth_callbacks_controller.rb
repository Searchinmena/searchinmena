module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    inject :user_repository

    def facebook
      user = user_repository.find_by_omniauth(request.env["omniauth.auth"])
      if user_exists?(user)
        sign_in(user, event: :authentication)
        redirect_to dashboard_path
      else
        session["devise.auth_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url
      end
    end

    private

    def user_exists?(user)
      user && user.persisted?
    end
  end
end
