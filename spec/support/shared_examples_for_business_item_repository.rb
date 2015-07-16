shared_examples "BusinessItemRepository" do
  describe "#photo_url" do
    subject { repository.photo_url_for(product, type) }

    let(:product) { create(:product) }
    let(:type) { nil }

    it { is_expected.to be_present }

    context "no photo present" do
      let(:product) { create(:product, photos: []) }

      it { is_expected.to be_nil }
    end

    context "thumb" do
      let(:type) { :thumb }

      it { is_expected.to be_present }
    end
  end
end
