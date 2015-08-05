shared_examples "business item attributes creator" do
  describe "#perform" do
    let(:creator) do
      described_class.new(repository, attribute, attribute_params)
    end
    let(:attribute_params) do
      { name: "attr2", value: "value2" }
    end
    let(:attribute) do
      repository.new_for_business_item(
        business_item,
        attribute_params
      )
    end

    subject { creator.perform }

    it { is_expected.to be_successful }

    it "saves attributes for business_item" do
      subject
      expect(attributes.count).to eq(1)
    end
  end
end
