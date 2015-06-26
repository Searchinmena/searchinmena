require "rails_helper"

describe CategoryRepository do
  let(:repository) { CategoryRepository.new }

  it_behaves_like "any repository"

  describe "#find_by_key" do
    subject { repository.find_by_key(key) }

    let!(:category) { create(:category) }

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
    let(:category) { build(:category) }
    let(:parent) { create(:category) }

    before { repository.update_parent(category, parent) }

    it { expect(category.reload.parent).to eq(parent) }
  end
end
