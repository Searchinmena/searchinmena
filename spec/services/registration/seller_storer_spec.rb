require "rails_helper"

describe Registration::SellerStorer do
  describe "initialize" do
    let(:user) { double(:user) }
    let(:user_params) { double(:user_params) }
    let(:business) { double(:business) }
    let(:business_params) { double(:business_params) }
    let(:tags_params) { double(:tags_params) }
    let(:logo_params) { nil }
    let(:locale) { "en" }
    let(:records) { { user: user, business: business } }
    let(:registration_params) do
      {
        user: user_params,
        business: business_params,
        tags: tags_params,
        logo: logo_params,
        locale: locale
      }
    end

    let(:user_creator) { double(:user_creator) }
    let(:business_saver) { double(:business_saver) }

    before do
      expect(Registration::UserCreator).to receive(:new)
        .with(user, user_params).and_return(user_creator)
      expect(BaseBusinessSaver).to receive(:new)
        .with(business, business_params, tags_params, logo_params, locale, user)
        .and_return(business_saver)
    end

    it "creates user and business handlers" do
      storer = Registration::SellerStorer.new(records, registration_params)
      expect(storer.handlers).to eq([user_creator, business_saver])
    end
  end
end

