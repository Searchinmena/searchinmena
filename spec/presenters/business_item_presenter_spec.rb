require "rails_helper"

describe BusinessItemPresenter do
  describe "#as_json" do
    let(:product) { create(:product) }
    let(:presenter) { BusinessItemPresenter.new(product) }

    subject { presenter.as_json }

    it { is_expected.to eq(id: product.id) }
  end
end
