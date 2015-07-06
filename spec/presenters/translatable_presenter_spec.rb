require "rails_helper"

describe TranslatablePresenter do
  describe "#as_json" do
    let(:presenter) { TranslatablePresenter.new(unit) }
    let(:unit) { create(:unit) }
    let!(:translation) { create(:translation, translatable: unit) }

    subject { presenter.as_json }

    it { is_expected.to eq(id: unit.id, label: translation.value) }
  end
end
