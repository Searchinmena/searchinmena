require "rails_helper"

describe CategoryPresenter do
  describe "#as_json" do
    let(:presenter) { CategoryPresenter.new(category) }
    let(:category) { create(:product_category) }
    let!(:translation) { create(:category_translation, category: category) }

    subject { presenter.as_json }

    it do
      is_expected.to eq(id: category.id,
                        name: translation.value,
                        parent_id: category.parent_id)
    end
  end
end
