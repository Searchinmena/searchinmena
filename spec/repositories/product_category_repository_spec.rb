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

  describe "#for_parent_id" do
    let!(:parent) { create(:product_category) }
    let!(:category) { create(:product_category, parent: parent) }

    before do
      [parent, category].each do |o|
        %w{en ar}.each do |locale|
          create(:translation, key: o.key, locale: locale)
        end
      end
    end

    subject do
      repository.for_parent_id(parent.id, "en").first.translations.first
    end

    it { expect(subject.key).to eq(category.key) }
    it { expect(subject.locale).to eq("en") }
  end
end
