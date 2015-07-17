require "rails_helper"

describe AttributePresenter do
  describe "#as_json" do
    let(:product_attribute) { create(:product_attribute) }
    let(:presenter) { described_class.new(product_attribute) }

    subject { presenter.as_json.keys }

    it { is_expected.to eq([:name, :value]) }
  end
end
