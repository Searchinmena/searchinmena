shared_examples "BusinessItemsController" do
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

  describe "#create" do
    it_behaves_like "redirects to signin if user not logged in" do
      before { post :create }
    end

    context "user is logged in" do
      let(:user) { create(:seller) }

      before { sign_in(user) }

      let(:creator) { double(:creator, perform: creator_response) }
      let(:creator_response) { double(successful?: successful, object: business_item) }
      let(:attributes_params) { {} }
      let(:business_item) { double(:business_item) }
      let(:new_business_item_params) do
        {
          business_item: business_item_params,
          attributes: attributes_params
        }
      end

      before do
        expect(creator_class).to receive(:new)
          .with(new_business_item_params, user).and_return(creator)
      end

      context "creator response is successful" do
        let(:successful) { true }

        it "is successful" do
          expect(BusinessItemPresenter).to receive(:new).with(business_item)

          post :create, business_item: business_item_params,
                        attributes: attributes_params
          expect(response).to be_successful
        end
      end

      context "creator response is not successful" do
        let(:successful) { false }

        it "renders errors" do
          expect(ErrorsPresenter).to receive(:new).with(business_item)

          post :create, business_item: business_item_params,
                        attributes: attributes_params
          expect(response.status).to eq(409)
        end
      end
    end
  end
end
