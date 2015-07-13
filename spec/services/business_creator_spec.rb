require "rails_helper"

describe Business::Creator do
  let(:creator) do
    described_class.new(business, business_params, tags_params, locale, user)
  end
  let(:user) { create(:user) }
  let(:business_type) { create(:business_type) }
  let(:business) { build(:business) }
  let(:business_params) do
    build_business_params(business)
  end
  let(:tags_params) { {} }
  let(:locale) { "en" }
  let(:valid) { false }
  let(:validator) do
    double(:validator, valid?: valid, errors?: !valid, copy_errors: nil)
  end

  before do
    expect(BusinessValidator).to receive(:new).with(business_params)
      .and_return(validator)
  end

  describe "#valid?" do
    subject { creator.valid? }

    it "delegates to business validator" do
      expect(validator).to receive(:valid?)
      subject
    end
  end

  describe "#perform" do
    subject { creator.perform }

    context "failed business creation" do
      let(:success) { false }
      let(:valid) { false }

      it { is_expected.not_to be_successful }

      it "doesn't save business" do
        expect { subject }.not_to change { Business.count }
      end
    end

    context "successful business creation" do
      let(:success) { true }
      let(:valid) { true }

      it { is_expected.to be_successful }

      it "saves business" do
        expect { subject }.to change { Business.count }.by(1)
        expect(user.business).to be_present
      end
    end
  end
end
