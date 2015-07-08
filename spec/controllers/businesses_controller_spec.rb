require "rails_helper"

describe BusinessesController do
  describe "#create" do
    it_behaves_like "redirects to signin if user not logged in" do
      before { post :create }
    end

    context "user is logged in" do
      let(:user) { create(:user) }
      let(:business) { build(:business) }
      let(:business_params) do
        {
          "name" => business.name,
          "country_id" => business.country_id.to_s,
          "phone" => business.phone
        }
      end
      let(:params) { { business: business_params } }
      let(:tags_params) { {} }
      let(:locale) { :en }
      let(:creator) { double(:creator) }
      let(:creator_response) do
        double(successful?: successful, object: business)
      end

      fake(:business_repository)

      before do
        sign_in(user)

        expect(controller).to receive(:business_repository)
          .and_return(business_repository)
        expect(business_repository).to receive(:new).and_return(business)
        expect(Business::Creator).to receive(:new)
          .with(business, business_params, tags_params, locale, user)
          .and_return(creator)
        expect(creator).to receive(:perform).and_return(creator_response)

        post :create, params
      end

      context "creation successful" do
        let(:successful) { true }

        it { expect(response).to be_successful }
      end

      context "creation failed" do
        let(:successful) { false }

        it { expect(response).not_to be_successful }
      end
    end
  end
end
