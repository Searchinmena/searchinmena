require "rails_helper"

describe RegistrationsController do
  let(:user) { build(:user) }
  let(:business) { build(:business, user: nil) }
  let(:sign_up_params) do
    {
      "email" => user.email,
      "password" => user.password,
      "password_confirmation" => user.password_confirmation
    }
  end

  fake(:user_params_factory)

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "#new" do
    fake(:business_repository)
    fake(:user_repository)

    before do
      expect(controller).to receive(:user_params_factory)
      .and_return(user_params_factory)
      expect(controller).to receive(:user_repository)
      .and_return(user_repository)
      expect(user_params_factory).to receive(:build).and_return(sign_up_params)
      expect(user_repository).to receive(:new).with(sign_up_params)
      .and_return(user)
      expect(controller).to receive(:business_repository)
      .and_return(business_repository)
      expect(business_repository).to receive(:new).and_return(business)
      expect(session["devise.auth_data"]).to eq(nil)
    end

    it "is successful" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "#create" do
    let(:business_params) do
      {
        "name" => business.name,
        "country" => business.country,
        "phone" => business.phone,
        "business_type" => business.business_type.to_s
      }
    end
    let(:user_params) { sign_up_params.merge(business: business_params) }
    let(:registration_creator) { double }

    before do
      response = double(successful?: successful, user: user, business: business)
      expect(Registration::Creator).to receive(:new)
        .with(sign_up_params, business_params)
        .and_return(registration_creator)
      expect(registration_creator).to receive(:perform).and_return(response)

      post :create, user: user_params
    end

    context "successful user creation" do
      let(:successful) { true }

      it "redirects to dashboard" do
        expect(response).to redirect_to(dashboard_path)
      end
    end

    context "user creation failed" do
      let(:successful) { false }

      it "renders new" do
        expect(response).to render_template(:new)
      end
    end
  end
end
