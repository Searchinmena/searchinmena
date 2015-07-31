require "rails_helper"

describe Users::OmniauthCallbacksController do
  before do
    request.env["devise.mapping"] = Devise.mappings[:user]
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
  end

  describe "#facebook" do
    fake(:user_repository)

    before do
      expect(controller).to receive(:user_repository)
      .and_return(user_repository)
      expect(user_repository).to receive(:find_by_omniauth)
      .with(request.env["omniauth.auth"]).and_return(user)
      get :facebook
    end

    context "when user exists" do
      let(:user) { create(:user, provider: "facebook", uid: "123456") }

      it { expect(response).to redirect_to(Sim::Routes.dashboard_path) }
    end

    context "when user doesn't exist" do
      let(:user) { nil }

      it "stores auth hash in session" do
        expect(session["devise.auth_data"]).to eq(request.env["omniauth.auth"])
      end

      it "redirects to signup page" do
        expect(response).to redirect_to(new_user_registration_url)
      end
    end
  end
end
