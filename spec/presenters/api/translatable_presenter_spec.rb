require "rails_helper"

describe Api::TranslatablePresenter do
  describe "#as_json" do
    let(:presenter) { Api::TranslatablePresenter.new(unit) }
    let(:unit) { create(:unit) }
    let!(:translation) { create(:translation, key: unit.key) }

    subject { presenter.as_json }

    it { is_expected.to eq(id: unit.id, label: translation.value) }
  end
end
