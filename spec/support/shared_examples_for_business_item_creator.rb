shared_examples "business item creator" do
  describe "#perform" do
    let(:photo) { test_image }

    let(:business_item_params) do
      build_params(business_item).merge(business: user.business)
    end
    let(:user) { create(:seller) }

    subject { creator.perform }

    context "business item validation passed" do
      let(:creator) do
        described_class.new(
          business_item, business_item_params, [], [], [photo]
        )
      end

      it { is_expected.to be_successful }

      it "saves business item" do
        subject
        expect(business_items).not_to be_empty
      end
    end

    context "business item validation failed" do
      let(:creator) do
        described_class.new(business_item, business_item_params, [], [], [])
      end

      it { is_expected.not_to be_successful }

      it "doesn't save business item" do
        subject
        expect(business_items).to be_empty
      end
    end
  end
end
