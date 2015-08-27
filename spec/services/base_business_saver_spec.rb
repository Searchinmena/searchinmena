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
  let(:success) { true }

  let(:response) { double(:reponse, successful?: success) }
  let(:storing_handler) do
    double(:storing_handler, valid?: valid, perform: response)
  end

  before do
    expect(BusinessStoringHandler).to receive(:new)
      .and_return(storing_handler)
  end

  describe "#valid?" do
    subject { saver.valid? }

    it "validates" do
      expect(storing_handler).to receive(:valid?)
      subject
    end
  end

  describe "#perform" do
    subject { saver.perform }

    context "failed business creation" do
      let(:valid) { false }
      let(:success) { false }

      it { is_expected.not_to be_successful }

      it "doesn't save business" do
        expect { subject }.not_to change { Business.count }
      end
    end

    context "successful business creation" do
      let(:valid) { true }

      it { is_expected.to be_successful }

      it "saves business" do
        expect { subject }.to change { Business.count }.by(1)
        expect(user.business).to be_present
      end
    end
  end
end
