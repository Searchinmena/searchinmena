shared_examples "ServiceResourceRepository" do
  describe "#attributes_with_business_item" do
    let(:business_item) { double }
    let(:repository) { described_class.new }

    subject do
      repository.attributes_with_business_item({ ania: 'foo' },
                                               business_item)
    end

    it { is_expected.to eq(ania: 'foo', service: business_item) }
  end
end
