require "rails_helper"

describe BusinessItem::ProductAttributesCreator do
  it_behaves_like "business item attributes creator" do
    let(:business_item) { create(:product) }
    let(:attributes) { business_item.product_attributes }
  end
end
