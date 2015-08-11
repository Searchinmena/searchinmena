shared_examples "PhotoRepository" do
  describe "#photo_url" do
    let(:s3_url) { "http://s3/photo.jpg" }
    let(:photo) { double(photo_url: s3_url) }
    let(:type) { nil }

    subject { repository.photo_url(photo, type) }

    it { is_expected.to eq(s3_url) }

    context "photo missing" do
      let(:photo) { nil }

      it { is_expected.to eq('/assets/default-image.png') }
    end

    context "photo not yet uploaded to S3" do
      let(:photo) { double(photo_url: nil, photo_tmp: "temp_dir/name.jpg") }

      it { is_expected.to eq('/uploads/tmp/temp_dir/name.jpg') }
    end

    context "thumb" do
      let(:type) { :thumb }

      it do
        expect(photo).to receive(:photo_url).with(type)
        is_expected.to eq(s3_url)
      end

      context "photo missing" do
        let(:photo) { nil }

        it { is_expected.to eq('/assets/default-image-thumb.png') }
      end

      context "photo not yet uploaded to S3" do
        let(:photo) { double(photo_url: nil, photo_tmp: "temp_dir/name.jpg") }

        it { is_expected.to eq('/uploads/tmp/temp_dir/thumb_name.jpg') }
      end
    end
  end
end
