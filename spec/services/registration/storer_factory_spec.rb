require "rails_helper"

describe Registration::StorerFactory do
  describe "#from_category" do
    let(:factory) { Registration::StorerFactory.new }

    subject { factory.from_category(category, records, registration_params) }
    let(:records) { double(:records) }
    let(:registration_params) { double(:registration_params) }

    after { subject }

    context "seller category" do
      let(:category) { "seller" }

      it "creates SellerStorer" do
        expect(Registration::SellerStorer).to receive(:new)
          .with(records, registration_params)
      end
    end

    context "buyer category" do
      let(:category) { "buyer" }

      it "creates SellerStorer" do
        expect(Registration::BuyerStorer).to receive(:new)
          .with(records, registration_params)
      end
    end

    context "no category" do
      let(:category) { "" }

      it "creates SellerStorer" do
        expect(Registration::BuyerStorer).to receive(:new)
          .with(records, registration_params)
      end
    end
  end
end

