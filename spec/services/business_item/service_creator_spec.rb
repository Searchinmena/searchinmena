require 'rails_helper'

describe BusinessItem::ServiceStoringHandler do
  it_behaves_like "business item creator" do
    let(:business_item) { build(:service) }
    let(:validator_factory) { ServiceValidator }
    let(:business_items) { user.business.products }
  end
end
