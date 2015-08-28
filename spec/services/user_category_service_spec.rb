require "rails_helper"

describe UserCategoryService do
  let(:user_repository) do
    double(:user_repository, perform: double(succesful?: true))
  end

  describe "#perform" do
    subject { service.perform }

    context "user has type buyer" do
      let(:user) { build(:buyer) }
      let(:business) { build(:business) }
      let(:service) { described_class.new(user_repository, user, business) }

      before do
        expect(user_repository).to receive(:update_category).with(user, "both")
          .and_return(true)
      end

      it { is_expected.to be_successful }
    end

    context "user has type other than buyer" do
      let(:user) { build(:seller) }
      let(:service) { described_class.new(user_repository, user) }

      it "doesn't update category" do
        expect(user_repository).not_to receive(:update_category)
        subject
      end

      it { is_expected.to be_successful }
    end
  end
end
