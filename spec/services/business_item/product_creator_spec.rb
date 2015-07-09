require 'rails_helper'

describe BusinessItem::ProductCreator do
  it_behaves_like "business item creator" do
    let(:business_item) { build(:product) }
    let(:validator_factory) { ProductValidator }
    let(:attributes_creator_class) { BusinessItem::ProductAttributesCreator }
    let(:business_items) { user.business.products }
  end
end
