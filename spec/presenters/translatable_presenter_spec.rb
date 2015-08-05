require "rails_helper"

describe TranslatablePresenter do
  describe "#as_json" do
    let(:presenter) { TranslatablePresenter.new(unit) }
    let(:translation) { create(:translation) }
    let(:unit) { create(:unit, translations: [translation]) }

    subject { presenter.as_json }

    it { is_expected.to eq(id: unit.id, label: translation.value) }
  end
end
