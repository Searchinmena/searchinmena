require "rails_helper"

describe BusinessItemBasicPresenter do
  describe "#as_json" do
    let(:product) { create(:product) }
    let(:presenter) { BusinessItemBasicPresenter.new(product) }

    subject { presenter.as_json.keys }

    it { is_expected.to eq([:id, :name, :breadcrumbs, :thumb_url]) }
  end
end
