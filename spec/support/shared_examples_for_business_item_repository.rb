shared_examples "BusinessItemRepository" do
  describe "#photo_url" do
    subject { repository.photo_url_for(product, type) }

    let(:product) { create(:product) }
    let(:type) { nil }

    it { is_expected.to be_present }

    context "thumb" do
      let(:type) { :thumb }

      it { is_expected.to be_present }
    end

    context "no photo present" do
      let(:product) { create(:product, photos: []) }

      it { is_expected.to eq("/assets/default-image.png") }


      context "thumb" do
        let(:type) { :thumb }

        it { is_expected.to eq("/assets/default-image-thumb.png") }
      end
    end
  end
end
