shared_examples "SearchStrategy" do
  describe "#perform" do
    subject { strategy.perform(query) }

    let(:strategy) { described_class.new(repositories, validator_factory) }
    let(:repositories) do
      {
        product: product_repository,
        service: service_repository,
        business: business_repository
      }
    end
    let(:validator_factory) { double(:validator_factory, new: validator) }
    let(:validator) { double(:validator, valid?: valid, errors: errors) }
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

    context "query is valid" do
      let(:valid) { true }

      it { is_expected.to be_successful }

      it "returns response with results" do
        expect(subject.results).to eq(results)
      end
    end

    context "query is invalid" do
      let(:valid) { false }

      it { is_expected.not_to be_successful }

      it "returns response with errors" do
        expect(subject.errors).to eq(errors)
      end
    end
  end
end

