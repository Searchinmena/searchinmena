require "rails_helper"

describe User do
  describe "validations" do
    it { build(:user).should be_valid }

    describe "category" do
      it { build(:user, category: nil).should_not be_valid }
    end
  end

  describe "#category_name" do
    it "looks for appropriate translation" do
      expect(I18n).to receive(:t).with("user.types.seller")
      User.category_name(:seller)
    end
  end
end
