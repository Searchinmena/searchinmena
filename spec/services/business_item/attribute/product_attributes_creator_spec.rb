require "rails_helper"

describe BusinessItem::Attribute::Creator do
  context 'for product' do
    it_behaves_like "business item attributes creator" do
      let(:repository) { ProductAttributeRepository.new }
      let(:business_item) { create(:product) }
      let(:attributes) { business_item.product_attributes }
    end
  end

  context 'for service' do
    it_behaves_like "business item attributes creator" do
      let(:repository) { ServiceAttributeRepository.new }
      let(:business_item) { create(:service) }
      let(:attributes) { business_item.service_attributes }
    end
  end
end
