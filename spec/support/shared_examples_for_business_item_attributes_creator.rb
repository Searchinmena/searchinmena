shared_examples "business item attributes creator" do
  describe "#perform" do
    let(:creator) { described_class.new(attributes_params, business_item) }
    let(:attributes_params) do
      [{ name: "attr1", value: "value1" }, { name: "attr2", value: "value2" }]
    end

    subject { creator.perform }

    it { is_expected.to be_successful }

    it "saves attributes for business_item" do
      subject
      expect(attributes.count).to eq(2)
    end
  end
end

