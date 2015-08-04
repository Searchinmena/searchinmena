shared_examples "business item payment terms creator" do
  describe "#perform" do
    let(:creator) do
      described_class.new(repository, payment_terms_params, business_item)
    end
    let(:payment_terms_params) { 2.times.map { create(:payment_term).id } }

    subject { creator.perform }

    it { is_expected.to be_successful }

    it "saves payment_terms for business_item" do
      subject
      expect(business_item.payment_terms.count).to eq(2)
    end
  end
end

