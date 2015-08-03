require "rails_helper"

describe BusinessItem::PaymentTerms::Creator do
  context 'for product' do
    it_behaves_like "business item payment terms creator" do
      let(:repository) { ProductPaymentTermRepository.new }
      let(:business_item) { create(:product) }
    end
  end

  context 'for service' do
    it_behaves_like "business item payment terms creator" do
      let(:repository) { ServicePaymentTermRepository.new }
      let(:business_item) { create(:service) }
    end
  end
end
