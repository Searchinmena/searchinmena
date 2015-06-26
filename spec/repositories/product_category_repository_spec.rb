require "rails_helper"

describe ProductCategoryRepository do
  let(:repository) { ProductCategoryRepository.new }

  it_behaves_like "any repository"

  describe "#find_by_key" do
    subject { repository.find_by_key(key) }

    let!(:category) { create(:product_category) }

    context "category found" do
      let(:key) { category.key }

      it { is_expected.to eq(category) }
    end

    context "category not found" do
      let(:key) { "not existing key" }

      it { is_expected.to be_nil }
    end
  end

  describe "#update_parent" do
    let(:category) { build(:product_category) }
    let(:parent) { create(:product_category) }

    before { repository.update_parent(category, parent) }

    it { expect(category.reload.parent).to eq(parent) }
  end
end
