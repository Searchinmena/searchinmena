require "rails_helper"

describe BusinessItemWithCategoryPresenter do
  describe "#as_json" do
    let(:product) { create(:product) }
    let(:product_repository) { ProductRepository.new }
    let(:locale) { 'en' }
    let(:presenter) do
      BusinessItemWithCategoryPresenter.new(product, product_repository,
                                              locale)
    end

    subject { presenter.as_json.keys }

    it { is_expected.to eq([:id, :name, :breadcrumbs, :thumb_url]) }
  end
end
