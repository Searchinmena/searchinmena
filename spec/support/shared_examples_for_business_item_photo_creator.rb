shared_examples "business item photo creator" do
  describe "#perform" do
    let(:service) { described_class.new(repository) }
    let(:validator) do
      double(:validator, valid?: true, errors?: false)
    end

    let(:photo) { test_image }

    it "saves photo for business_item" do
      expect(BusinessItemPhotoValidator).to receive(:new)
        .and_return(validator)

      service.perform(business_item, photo)

      expect(business_item.photos).not_to be_empty
    end
  end
end
