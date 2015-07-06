require "rails_helper"

describe Registration::BuyerStorer do
  describe "initialize" do
    let(:user) { double(:user) }
    let(:user_params) { double(:user_params) }
    let(:records) { { user: user } }
    let(:registration_params) { { user: user_params } }

    it "creates user handler" do
      handler = double
      expect(Registration::UserCreator).to receive(:new)
        .with(user, user_params).and_return(handler)

      storer = Registration::BuyerStorer.new(records, registration_params)
      expect(storer.handlers).to eq([handler])
    end
  end
end

