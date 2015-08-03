require "rails_helper"

describe BusinessItem::Photo::Creator do
  context 'for product' do
    it_behaves_like "business item photo creator" do
      let(:repository) { ProductPhotoRepository.new }
      let(:business_item) { create(:product) }
      let(:photos) { business_item.photos }
    end
  end

  context 'for service' do
    it_behaves_like "business item photo creator" do
      let(:repository) { ServicePhotoRepository.new }
      let(:business_item) { create(:service) }
      let(:photos) { business_item.photos }
    end
  end
end
