module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def facebook
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
