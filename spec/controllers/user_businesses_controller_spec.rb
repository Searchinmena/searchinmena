require "rails_helper"

describe UserBusinessesController do
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
        let(:locale) { :en }

        before do
          expect(BusinessPresenter).to receive(:new).with(business, locale)
        end

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
      fake(:user_category_service)

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
      let(:params) { { business: business_params.to_json } }
      let(:tags_params) { {} }
      let(:logo_params) { { "logo" => nil } }
      let(:locale) { :en }

      let(:base_business_saver) { double(:base_business_saver) }
      let(:photos_storing_handler) do
        double(:photos_storing_handler, photos: photos)
      end

      let(:business_saver) { double(:business_saver) }
      let(:saver_response) do
        double(successful?: successful, object: business, photos: photos)
      end
      let(:handlers) do
        [base_business_saver, photos_storing_handler, user_category_service]
      end
      let(:photos) { double(:photos, select: []) }

      before do
        sign_in(user)

        expect(controller).to receive(:business_repository)
          .and_return(business_repository)
        expect(business_repository).to receive(:find_or_build)
          .and_return(business)
        expect(BaseBusinessSaver).to receive(:new)
          .with(business, business_params, tags_params,
                logo_params, locale, user)
          .and_return(base_business_saver)

        expect(UserCategoryService).to receive(:new)
          .and_return(user_category_service)

        expect(Business::PhotosStoringHandler).to receive(:new).twice
          .and_return(photos_storing_handler)
        expect(photos_storing_handler).to receive(:photos)
          .and_return(photos)

        expect(Business::Saver).to receive(:new)
          .with(handlers, business, photos)
          .and_return(business_saver)
        expect(business_saver).to receive(:perform).and_return(saver_response)

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
