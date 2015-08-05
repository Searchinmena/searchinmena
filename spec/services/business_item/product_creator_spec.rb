require 'rails_helper'

describe BusinessItem::ProductStoringHandler do
  it_behaves_like "business item creator" do
    let(:business_item) { build(:product) }
    let(:validator_factory) { ProductValidator }
    let(:business_items) { user.business.products }
  end
end
