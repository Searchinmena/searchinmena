require "rails_helper"

describe OmniauthController do
  describe "#localized" do
    before { get :localized, provider: :facebook }

    it { expect(session[:omniauth_locale]).to eq(I18n.locale) }
    it { expect(response).to redirect_to user_omniauth_authorize_path }
  end
end
