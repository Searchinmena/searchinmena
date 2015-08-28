require "rails_helper"

describe BusinessStoringHandler do
  let(:handler) do
    described_class.new(business,
                        params,
                        locale,
                        business_validator,
                        logo_validator)
  end

  subject { handler.perform }

  let(:business) { double(:business) }
  let(:business_params) { double(:business_params) }
  let(:tags_params) { double(:tags_params) }
  let(:logo_params) { double(:logo_params) }
  let(:locale) { "en" }

  let(:params) do
    {
      business: business_params,
      tags: tags_params,
      logo: logo_params
    }
  end

  fake(:business_repository)
  fake(:business_validator)
  fake(:storing_handler)
  fake(:tags_storing_handler)
  fake(:logo_storing_handler)
  fake(:logo_validator)

  before do
    expect(BusinessRepository).to receive(:new)
      .and_return(business_repository)
    expect(StoringHandler).to receive(:new)
      .with(business, params[:business], business_repository,
            business_validator)
      .and_return(storing_handler)
    expect(TagsStoringHandler).to receive(:new)
      .with(business, params[:tags], locale)
      .and_return(tags_storing_handler)
    expect(LogoStoringHandler).to receive(:new)
      .with(business, logo_validator, params[:logo])
      .and_return(logo_storing_handler)
  end

  describe "#perform" do
    let(:response) { Response.new(success: true) }

    it "performs storing handler and tags storing handler" do
      [storing_handler,
       tags_storing_handler,
       logo_storing_handler].each do |handler|
        expect(handler).to receive(:perform).and_return(response)
      end

      is_expected.to be_successful
    end
  end
end

