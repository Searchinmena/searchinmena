class OmniauthController < ApplicationController
  skip_before_filter :authenticate_user!

  def localized
    session[:omniauth_locale] = I18n.locale
    redirect_to user_omniauth_authorize_path(params[:provider])
  end
end
