require "rails_helper"

describe BusinessItem::ProductPhotoCreator do
  it_behaves_like "business item photo creator" do
    let(:repository) { ProductPhotoRepository.new }
    let(:business_item) { create(:product) }
    let(:photos) { business_item.photos }
  end
end
