require "rails_helper"

describe UserPresenter do
  describe "#as_json" do
    let(:presenter) { UserPresenter.new(user) }
    let(:user) { build(:user, provider: "facebook", uid: "1234567") }

    subject { presenter.as_json }

    it "includes prefilled attributes" do
      is_expected.to include(
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email,
        provider: user.provider,
        uid: user.uid
      )
    end
  end
end
