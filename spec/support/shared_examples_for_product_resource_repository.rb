shared_examples "ProductResourceRepository" do
  describe "#attributes_with_business_item" do
    let(:business_item) { double }
    let(:repository) { described_class.new }

    subject { repository.attributes_with_business_item({ ania: 'foo'}, business_item) }

    it { is_expected.to eq({ ania: 'foo', product: business_item }) }
  end
end
