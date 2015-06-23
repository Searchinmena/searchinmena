require "rails_helper"

describe ProductRepository do
  let(:repository) { ProductRepository.new }

  it_behaves_like "each Repository"

  describe "#find_for_user" do
    subject { repository.find_for_user(user, id) }

    context "user with business" do
      let(:user) { create(:seller) }
      let!(:product) { create(:product, business: user.business) }
      let(:id) { product.id }

      it { is_expected.to eq(product) }

      context "product not found" do
        let(:id) { "not existing id" }

        it { is_expected.to eq(nil) }
      end
    end

    context "user without business" do
      let(:user) { create(:user) }
      let(:id) { 4 }

      it { is_expected.to eq(nil) }
    end
  end
end
