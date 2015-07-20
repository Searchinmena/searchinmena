require "rails_helper"

describe PhotoPresenter do
  describe "#as_json" do
    let(:product_photo) { create(:product_photo) }
    let(:presenter) { described_class.new(product_photo) }

    subject { presenter.as_json.keys }

    it { is_expected.to eq([:thumb, :url]) }
  end
end
