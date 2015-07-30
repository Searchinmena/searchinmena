require "rails_helper"

describe UserPresenter do
  describe "#as_json" do
    let(:presenter) { UserPresenter.new(user) }
    let(:user) { build(:buyer, provider: "facebook", uid: "1234567") }
    let(:can_see_business_items) { false }

    subject { presenter.as_json }

    before do
      expect(user).to receive(:can_see_business_items?)
        .and_return(can_see_business_items)
    end

    it "includes prefilled attributes" do
      is_expected.to include(
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email,
        provider: user.provider,
        uid: user.uid,
        can_see_business_items: can_see_business_items,
        confirmed_at: user.confirmed_at
      )
    end
  end
end
