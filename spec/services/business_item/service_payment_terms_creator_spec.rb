require "rails_helper"

describe BusinessItem::ServicePaymentTermsCreator do
  it_behaves_like "business item payment terms creator" do
    let(:business_item) { create(:service) }
  end
end
