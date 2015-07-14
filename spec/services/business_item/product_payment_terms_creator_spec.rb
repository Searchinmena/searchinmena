require "rails_helper"

describe BusinessItem::ProductPaymentTermsCreator do
  it_behaves_like "business item payment terms creator" do
    let(:business_item) { create(:product) }
  end
end
