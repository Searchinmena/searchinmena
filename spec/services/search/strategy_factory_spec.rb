require "rails_helper"

describe Search::Service do
  let(:factory) do
    Search::StrategyFactory.new(product_repository,
                                service_repository,
                                business_repository)
  end
  fake(:product_repository)
  fake(:service_repository)
  fake(:business_repository)

  describe "#build" do
    subject { factory.build(type) }

    let(:type) { :product }
    let(:repositories) do
      {
        product: product_repository,
        service: service_repository,
        business: business_repository
      }
    end

    it do
      expect(Search::Strategies::ProductStrategy).to receive(:new)
        .with(repositories, SearchQueryValidator)

      subject
    end
  end
end

