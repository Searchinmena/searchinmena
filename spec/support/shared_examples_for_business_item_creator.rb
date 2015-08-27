shared_examples "business item creator" do
  describe "#perform" do
    let(:creator) do
      described_class.new(
        business_item, business_item_params, [], [], photo_params
      )
    end

    let(:photos) { [test_image] }
    let(:photo_params) do
      BusinessItem::Photo::Params.new([], photos)
    end

    let(:business_item_params) do
      build_params(business_item).merge(business: user.business)
    end
    let(:user) { create(:seller) }

    subject { creator.perform }

    context "business item validation passed" do
      it { is_expected.to be_successful }

      it "saves business item" do
        subject
        expect(business_items).not_to be_empty
      end
    end

    context "business item validation failed" do
      let(:photos) { [] }

      it { is_expected.not_to be_successful }

      it "doesn't save business item" do
        subject
        expect(business_items).to be_empty
      end
    end
  end
end
