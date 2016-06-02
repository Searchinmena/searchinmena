require "rails_helper"

describe SearchController do
  describe "#create" do
    let(:business) { create(:business) }
    let(:type) { "product" }
    let(:query) do
      {
        type: "product",
        query: "some product",
        controller: "search",
        action: "index"
      }
    end
    let(:search_service) { double(:search_service) }
    let(:search_response) { Search::Response.new(success: successful) }

    context "index serch" do
      before do
        expect(controller).to receive(:search_service)
          .and_return(search_service)
        expect(search_service).to receive(:perform)
          .with(type, query).and_return(search_response)

        get :index, type: type, query: query[:query]
      end

      context "search is successful" do
        let(:successful) { true }

        it { expect(response).to be_successful }
      end

      context "search is not successful" do
        let(:successful) { false }

        it { expect(response).not_to be_successful }
      end
    end
    context "auto search serch" do
      let(:product) { create(:product) }
      let(:autocomplete_search) { double(:autocomplete_search) }
      let(:search_response) { Search::Response.new(success: successful) }
      let(:type) { :product }
      let(:query) do
        {
          "type" => "product",
          "query" => product.name,
          "controller" => "search",
          "action" => "autosuggestion"
        }
      end

      before do
        expect(controller).to receive(:autocomplete_search)
          .and_return(autocomplete_search)
        expect(autocomplete_search).to receive(:perform)
          .with(type, query).and_return(search_response)

        get :autosuggestion, type: type, query: query["query"]
      end

      context "search is successful" do
        let(:successful) { true }

        it { expect(response).to be_successful }
      end
    end
  end
end
