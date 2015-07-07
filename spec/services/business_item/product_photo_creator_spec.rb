require 'rails_helper'

describe BusinessItem::ProductPhotoCreator do
  describe "#perform" do
    let(:service) { described_class.new(product_photo_repository) }
    let(:product_photo_repository) { ProductPhotoRepository.new }
    let(:validator) do
      double(:validator, valid?: true, errors?: false)
    end

    let(:product) { create(:product) }
    let(:photo) { test_image }

    it "saves photo for product" do
      expect(BusinessItemPhotoValidator).to receive(:new)
        .and_return(validator)

      service.perform(product, photo)

      expect(product.photos).not_to be_empty
    end
  end
end
