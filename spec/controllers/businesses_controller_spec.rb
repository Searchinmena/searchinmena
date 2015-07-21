require "rails_helper"

describe BusinessesController do
  let(:user) { create(:buyer) }

  fake(:business_repository)

  describe "#show" do
    it_behaves_like "redirects to signin if user not logged in" do
      before { get :show }
    end

    context "user is logged in" do
      let(:business) { user.business }

      before do
        sign_in(user)

        expect(controller).to receive(:business_repository)
          .and_return(business_repository)
        expect(business_repository).to receive(:find_by_user_id).with(user.id)
          .and_return(business)
      end

      it "is not found" do
        get :show
        expect(response).to be_not_found
      end

      context "user has business" do
        let(:user) { create(:seller) }

        before { expect(BusinessPresenter).to receive(:new).with(business) }

        it "is successful" do
          get :show
          expect(response).to be_successful
        end
      end
    end
  end

  describe "#update" do
    it_behaves_like "redirects to signin if user not logged in" do
      before { put :update }
    end

    context "user is logged in" do
      let(:business) { build(:business) }
      let(:business_type) { create(:business_type) }
      let(:business_params) do
        {
          "name" => business.name,
          "country_id" => business.country_id.to_s,
          "phone" => business.phone,
          "business_type_ids" => [business_type.id.to_s]
        }
      end
      let(:params) { { business: business_params } }
      let(:tags_params) { {} }
      let(:locale) { :en }
      let(:saver) { double(:saver) }
      let(:saver_response) do
        double(successful?: successful, object: business)
      end

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
