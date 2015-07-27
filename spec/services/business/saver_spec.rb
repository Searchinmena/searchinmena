require "rails_helper"

describe Business::Saver do
  fake(:base_business_saver)
  fake(:user_category_service)

  let(:saver) do
    described_class.new(base_business_saver, user_category_service)
  end
  let(:user) { build(:user) }
  let(:business) { build(:business) }
  let(:response) { double(:response, successful?: true) }

  describe "#perform" do
    subject { saver.perform(user, business) }

    it "uses UserCategoryService to change category" do
      expect(saver).to receive(:base_business_saver)
        .and_return(base_business_saver)
      expect(base_business_saver).to receive(:perform)
        .and_return(response)

      expect(saver).to receive(:user_category_service)
        .and_return(user_category_service)
      expect(user_category_service).to receive(:perform).with(user, business)
        .and_return(response)

      is_expected.to be_successful
    end
  end
end
