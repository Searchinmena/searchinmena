require "rails_helper"

describe PaymentTermPresenter do
  describe "#as_json" do
    let(:payment_term) do
      pt = create(:payment_term)
      create(:translation, translatable: pt, value: 'translation')
      pt
    end
    let(:presenter) { described_class.new(payment_term) }

    subject { presenter.as_json }

    it { is_expected.to eq('translation') }
  end
end
