require 'rails_helper'

describe BusinessItem::ServiceCreator do
  it_behaves_like "business item creator" do
    let(:business_item) { build(:service) }
    let(:validator_factory) { ServiceValidator }
    let(:attributes_creator_class) { BusinessItem::ServiceAttributesCreator }
    let(:payment_terms_creator_class) do
      BusinessItem::ServicePaymentTermsCreator
    end
    let(:business_items) { user.business.services }
  end
end
