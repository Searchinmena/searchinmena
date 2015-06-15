require "rails_helper"

describe DashboardController do
  describe "#show" do
    it_behaves_like "redirects to signin if user not logged in" do
      before { get :show }
    end

    context "user is logged in" do
      let(:user) { create(:user) }

      before do
        sign_in(user)
        get :show
      end

      it { expect(response).to be_successful }
    end
  end
end
