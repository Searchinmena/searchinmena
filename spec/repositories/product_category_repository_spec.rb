require "rails_helper"

describe ProductCategoryRepository do
  let(:repository) { ProductCategoryRepository.new }

  it_behaves_like "TranslatableRepository"

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
          repository.create_translation(o, 'val', locale)
        end
      end
    end

    subject do
      repository.for_parent_id(parent.id, "en").first.translations.first
    end

    it { expect(subject.locale).to eq("en") }
  end
end
