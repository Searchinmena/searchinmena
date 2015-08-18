shared_examples "SearchStrategy" do
  describe "#perform" do
    subject { strategy.perform(query) }

    let(:strategy) { described_class.new(repositories) }
    let(:repositories) do
      {
        product: product_repository,
        service: service_repository,
        business: business_repository
      }
    end
    let(:product_repository) do
      double(:product_repository, where_name_like: results)
    end
    let(:service_repository) do
      double(:service_repository, where_name_like: results)
    end
    let(:business_repository) do
      double(:business_repository, where_name_like: results)
    end

    let(:query) { "query" }
    let(:results) { [double(:result)] }
    let(:errors) { { error: 'Error!' } }

    it { is_expected.to be_successful }

    it "returns response with results" do
      expect(subject.results).to eq(results)
    end
  end
end

