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
      let(:creator_response) do
        double(successful?: successful, object: business_item)
      end
      let(:attributes_params) { [{ name: "ania", value: "hai" }] }
      let(:payment_terms_params) { { "12" => true } }
      let(:business_item) { double(:business_item) }
      let(:new_business_item_params) do
        {
          business_item: business_item_params,
          attributes: attributes_params,
          payment_terms: payment_terms_params
        }
      end

      let(:expected_params) do
        new_business_item_params.merge(
          payment_terms: payment_terms_params.keys)
      end

      before do
        allow(controller).to receive(:repository)
          .and_return(repository)
        expect(creator_class).to receive(:new)
          .with(expected_params, user).and_return(creator)
      end

      context "creator response is successful" do
        let(:successful) { true }

        shared_examples_for "successful response" do
          it "is successful" do
            expect(BusinessItemBasicPresenter).to receive(:new)
              .with(business_item, repository)

            post :create, new_business_item_params
            expect(response).to be_successful
          end
        end

        it_behaves_like "successful response"

        context "attributes not present" do
          let(:attributes_params) { nil }
          let(:expected_params) do
            new_business_item_params.merge(
              attributes: [],
              payment_terms: payment_terms_params.keys
            )
          end

          it_behaves_like "successful response"
        end

        context "payment_terms not present" do
          let(:payment_terms_params) { nil }
          let(:expected_params) do
            new_business_item_params.merge(
              payment_terms: []
            )
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
end
