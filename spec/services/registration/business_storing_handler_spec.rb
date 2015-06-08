require 'rails_helper'

describe Registration::BusinessStoringHandler do
  let(:handler) do
    described_class.new(business,
                        business_params,
                        tags_params,
                        business_validator)
  end

  subject { handler.perform }

  let(:business) { double(:business) }
  let(:business_params) { double(:business_params) }
  let(:tags_params) { double(:tags_params) }

  fake(:business_validator)
  fake(:storing_handler)
  fake(:tags_storing_handler)
  fake(:business_repository)

  before do
    expect(BusinessRepository).to receive(:new)
      .and_return(business_repository)
    expect(StoringHandler).to receive(:new)
      .with(business, business_params, business_repository, business_validator)
      .and_return(storing_handler)
    expect(TagsStoringHandler).to receive(:new)
      .with(business, tags_params)
      .and_return(tags_storing_handler)
  end

  describe "#perform" do
    it "performs storing handler and tags storing handler" do
      [storing_handler, tags_storing_handler].each do |handler|
        expect(handler).to receive(:perform).and_return(true)
      end

      is_expected.to be_successful
    end
  end
end

