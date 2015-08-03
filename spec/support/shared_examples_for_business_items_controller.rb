shared_examples "BusinessItemsController" do |resource_name|
  let(:common_business_params) do
    {
      "name" => "name",
      "description" => "description",
      "category_id" => "1",
      "fob_price" => "2",
      "fob_price_currency_id" => "1",
      "supply_ability_capacity" => "2",
      "supply_ability_unit_id" => "1",
      "supply_ability_frequency_id" => "1",
      "packaging_details" => "packaging"
    }
  end
  let(:user) { create(:seller) }

  before do
    allow(controller).to receive(:repository)
      .and_return(repository)
  end

  describe "#create" do
    it_behaves_like "redirects to signin if user not logged in" do
      before { post :create }
    end

    context "user is logged in" do
      before { sign_in(user) }

      let(:creator) { double(:creator, perform: creator_response) }
      let(:creator_response) do
        double(successful?: successful, object: business_item)
      end
      let(:breadcrumbs_params) { [{ name: "ania", value: "hai" }] }
      let(:payment_terms_params) { { "12" => true } }
      let(:business_item) { double(:business_item) }
      let(:new_business_item_params) do
        {
          "#{resource_name}": business_item_params,
          breadcrumbs: breadcrumbs_params,
          payment_terms: payment_terms_params
        }
      end

      let(:expected_params) do
        {
          business_item: new_business_item_params[resource_name],
          attributes: breadcrumbs_params,
          payment_terms: payment_terms_params.keys
        }
      end

      before do
        expect(creator_class).to receive(:new)
          .with(expected_params, user).and_return(creator)
      end

      context "creator response is successful" do
        let(:successful) { true }

        shared_examples_for "successful response" do
          it "is successful" do
            expect(BusinessItemBasicPresenter).to receive(:new)
              .with(business_item)

            post :create, new_business_item_params
            expect(response).to be_successful
          end
        end

        it_behaves_like "successful response"

        context "breadcrumbs not present" do
          let(:breadcrumbs_params) { nil }
          let(:expected_params) do
            {
              business_item: new_business_item_params[resource_name],
              attributes: [],
              payment_terms: payment_terms_params.keys
            }
          end

          it_behaves_like "successful response"
        end

        context "payment_terms not present" do
          let(:payment_terms_params) { nil }
          let(:expected_params) do
            {
              business_item: new_business_item_params[resource_name],
              attributes: breadcrumbs_params,
              payment_terms: []
            }
          end

          it_behaves_like "successful response"
        end
      end

      context "creator response is not successful" do
        let(:successful) { false }

        it "renders errors" do
          expect(ErrorsPresenter).to receive(:new).with(business_item)

          post :create, new_business_item_params
          expect(response.status).to eq(409)
        end
      end
    end
  end

  describe "#index" do
    it_behaves_like "redirects to signin if user not logged in" do
      before { post :index }
    end

    context "user is logged in" do
      before do
        sign_in(user)

        expect(BusinessItemsCollectionPresenter).to receive(:new)
          .with(user, "2", repository, :en)
      end

      subject { get :index, page: "2" }

      it { is_expected.to be_successful }
    end
  end

  describe "destroy" do
    it_behaves_like "redirects to signin if user not logged in" do
      before { delete :destroy, id: 1 }
    end

    context "user is logged in" do
      before do
        sign_in(user)
      end

      subject { delete :destroy, id: business_item.id, page: "2"  }

      context "business item belongs to the user" do
        let!(:business_item) { create(resource_name, business: user.business) }
        before do
          expect(BusinessItemsCollectionPresenter).to receive(:new)
            .with(user, "2", repository, :en)
        end

        it { is_expected.to be_successful }
      end

      context "business item doesn't belong to the user" do
        let!(:business_item) { create(resource_name) }

        it { is_expected.to be_not_found }
      end
    end
  end

  describe "show" do
    context "user is logged in" do
      before do
        sign_in(user)
      end

      subject { get :show, id: business_item.id, page: "2"  }

      context "business item belongs to the user" do
        let!(:business_item) { create(resource_name, business: user.business) }
        before do
          expect(BusinessItemPresenter).to receive(:new)
        end

        it { is_expected.to be_successful }
      end
    end
  end
end
