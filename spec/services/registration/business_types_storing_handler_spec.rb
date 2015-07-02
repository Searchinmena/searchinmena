require "rails_helper"

describe Registration::BusinessTypesStoringHandler do
  let(:handler) do
    described_class.new(business, business_types_params)
  end
  let(:business) { double(:business) }
  let(:business_types_params) { [business_type_id] }

  let(:business_type_id) { 381 }
  let(:business_type) { double(:business_type) }

  describe "#perform" do
    subject { handler.perform }

    fake(:business_type_repository)
    fake(:business_repository)

    before do
      expect(BusinessTypeRepository).to receive(:new)
        .and_return(business_type_repository)
      expect(BusinessRepository).to receive(:new)
        .and_return(business_repository)
    end

    it "adds business_type" do
      expect(business_type_repository).to receive(:find_by_id)
        .with(business_type_id).and_return(business_type)
      expect(business_repository).to receive(:add_business_type)
        .with(business, business_type).and_return(true)

      is_expected.to be_successful
    end
  end
end
