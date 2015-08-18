require "rails_helper"

describe Search::Service do
  let(:search_service) { Search::Service.new(search_strategy_factory) }
  let(:search_strategy_factory) do
    double(:search_strategy_factory, build: search_strategy)
  end
  let(:search_strategy) { double(:search_strategy, perform: nil) }

  describe "#perform" do
    subject { search_service.perform(search_params) }

    let(:search_params) { { type: 'product', query: 'query' } }

    context "type missing" do
      let(:search_params) { { query: 'query' } }

      it { expect { subject }.to raise_error(KeyError) }
    end

    context "query missing" do
      let(:search_params) { { type: 'product' } }

      it { expect { subject }.to raise_error(KeyError) }
    end

    it "runs proper strategy" do
      expect(search_strategy).to receive(:perform)
      subject
    end
  end
end

