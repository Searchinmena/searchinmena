require "rails_helper"

describe Registration::SellerStorer do
  describe "initialize" do
    let(:user) { double(:user) }
    let(:user_params) { double(:user_params) }
    let(:business) { double(:business) }
    let(:business_params) { double(:business_params) }
    let(:tags_params) { double(:tags_params) }
    let(:locale) { "en" }
    let(:records) { { user: user, business: business } }
    let(:registration_params) do
      {
        user: user_params,
        business: business_params,
        tags: tags_params,
        locale: locale
      }
    end

    let(:user_handler) { double(:user_handler) }
    let(:business_handler) { double(:business_handler) }

    before do
      expect(Registration::UserCreator).to receive(:new)
        .with(user, user_params).and_return(user_handler)
      expect(BaseBusinessSaver).to receive(:new)
        .with(business, business_params, tags_params, locale, user)
        .and_return(business_handler)
    end

    it "creates user and business handlers" do
      storer = Registration::SellerStorer.new(records, registration_params)
      expect(storer.handlers).to eq([user_handler, business_handler])
    end
  end
end

