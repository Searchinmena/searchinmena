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

    it "delegates validate?" do
      expect(storing_handler).to receive(:valid?)
      subject
    end
  end

  describe "#perform" do
    subject { saver.perform }

    it "delegates perform" do
      expect(storing_handler).to receive(:perform)
      subject
    end
  end
end
