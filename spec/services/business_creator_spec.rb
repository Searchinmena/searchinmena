require 'rails_helper'

describe BusinessCreator do
  describe "#perform" do
    let(:service) { BusinessCreator.new(business_repository) }
    fake(:business_repository)

    subject { service.perform(business_params, user) }

    let(:business) { build(:business) }
    let(:business_params) { {} }
    let(:user) { create(:user) }

    fake(:business_validator)
    fake(:storing_handler)
    let(:response) { Response.new(success: successful, object: business) }

    before do
      expect(business_repository).to receive(:new).and_return(business)
      expect(BusinessValidator).to receive(:new).with(business_params)
        .and_return(business_validator)
      expect(StoringHandler).to receive(:new)
        .with(business, business_params, business_repository,
             business_validator)
        .and_return(storing_handler)
      expect(storing_handler).to receive(:perform).and_return(response)
    end

    context "successful save" do
      let(:successful) { true }

      it { is_expected.to be_successful }

      it "assigns business to user" do
        subject
        expect(user.reload.business).not_to be_nil
      end
    end

    context "save failed" do
      let(:successful) { false }

      it { is_expected.not_to be_successful }
    end
  end
end
