require 'rails_helper'

describe Registration::BusinessCreator do
  let(:creator) do
    Registration::BusinessCreator.new(business, business_params,
                                      tags_params, user)
  end
  let(:business) { double(:business) }
  let(:business_params) { {} }
  let(:tags_params) { double(:tags_params) }
  let(:user) { double(:user) }

  fake(:business_validator)

  before do
    expect(BusinessValidator).to receive(:new).with(business_params)
      .and_return(business_validator)
  end

  describe "#valid?" do
    subject { creator.valid? }

    it "delegates to business validator" do
      expect(business_validator).to receive(:valid?)
      subject
    end
  end

  describe "#perform" do
    fake(:business_storing_handler)

    subject { creator.perform }

    before do
      expect(BusinessStoringHandler).to receive(:new)
      .with(business, { user: user }, tags_params, business_validator)
      .and_return(business_storing_handler)
    end

    it "delegates to storing handler" do
      expect(business_storing_handler).to receive(:perform)
      subject
    end
  end

  describe "#copy_errors" do
    subject { creator.copy_errors }

    it "copies errors to business" do
      expect(business_validator).to receive(:copy_errors)
        .with(business)
      subject
    end
  end
end

