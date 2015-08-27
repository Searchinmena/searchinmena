require "rails_helper"

describe BaseBusinessSaver do
  let(:saver) do
    described_class.new(business, business_params, tags_params,
                        logo_params, locale, user)
  end
  let(:user) { create(:buyer) }
  let(:business_type) { create(:business_type) }
  let(:business) { build(:business) }
  let(:business_params) do
    build_business_params(business)
  end
  let(:tags_params) { {} }
  let(:logo_params) { nil }
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
    subject { saver.valid? }

    it "delegates to business validator" do
      expect(validator).to receive(:valid?)
      subject
    end
  end

  describe "#perform" do
    subject { saver.perform }

    context "failed business creation" do
      let(:valid) { false }

      it { is_expected.not_to be_successful }

      it "doesn't save business" do
        expect { subject }.not_to change { Business.count }
      end
    end

    context "successful business creation" do
      let(:valid) { true }
      fake(:user_category_service)

      it { is_expected.to be_successful }

      it "saves business" do
        expect { subject }.to change { Business.count }.by(1)
        expect(user.business).to be_present
      end
    end
  end
end
