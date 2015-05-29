require "rails_helper"

describe Users::OmniauthCallbacksController do
  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
  end

  describe "#facebook" do
    before { get :facebook }

    it "stores auth hash in session" do
      expect(session["devise.auth_data"]).to eq(request.env["omniauth.auth"])
    end

    it "redirects to signup page with type facebook" do
      expect(response).to redirect_to(new_user_registration_url(type:
        :facebook))
    end
  end
end
