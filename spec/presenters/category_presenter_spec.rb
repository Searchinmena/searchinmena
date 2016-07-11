require "rails_helper"

describe CategoryPresenter do
  describe "#as_json" do
    let(:presenter) { CategoryPresenter.new(category) }
    let(:translation) { create(:category_translation) }
    let(:category) do
      create(:product_category, category_translations: [translation])
    end

    subject { presenter.as_json }

    it do
      is_expected.to eq(id: category.id,
                        name: translation.value,
                        parent_id: category.parent_id,
                        path: ERB::Util.url_encode(translation.value))
    end
  end
end
