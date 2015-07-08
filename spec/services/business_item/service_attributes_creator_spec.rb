require "rails_helper"

describe BusinessItem::ServiceAttributesCreator do
  it_behaves_like "business item attributes creator" do
    let(:business_item) { create(:service) }
    let(:attributes) { business_item.service_attributes }
  end
end
