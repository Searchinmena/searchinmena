require "rails_helper"

describe User do
  describe "validations" do
    it { expect(build(:user)).to be_valid }

    describe "category" do
      it { expect(build(:user, category: nil)).not_to be_valid }
    end
  end

  describe "#category_name" do
    it "returns appropriate translation" do
      expect(I18n).to receive(:t).with("user.types.seller").and_return("seller")
      expect(User.category_name(:seller)).to eq("seller")
    end
  end
end
