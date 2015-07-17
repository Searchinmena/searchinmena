require "rails_helper"

describe BusinessesController do
  describe "#update" do
    it_behaves_like "redirects to signin if user not logged in" do
      before { put :update }
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
      let(:saver) { double(:saver) }
      let(:saver_response) do
        double(successful?: successful, object: business)
      end

      fake(:business_repository)

      before do
        sign_in(user)

        expect(controller).to receive(:business_repository)
          .and_return(business_repository)
        expect(business_repository).to receive(:find_or_build)
          .and_return(business)
        expect(Business::Saver).to receive(:new)
          .with(business, business_params, tags_params, locale, user)
          .and_return(saver)
        expect(saver).to receive(:perform).and_return(saver_response)

        put :update, params
      end

      context "saving successful" do
        let(:successful) { true }

        it { expect(response).to be_successful }
      end

      context "saving failed" do
        let(:successful) { false }

        it { expect(response).not_to be_successful }
      end
    end
  end
end
