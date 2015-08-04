require "rails_helper"

describe PaymentTermPresenter do
  describe "#as_json" do
    let(:translation) { create(:translation, value: "translation") }
    let(:payment_term) { create(:payment_term, translations: [translation]) }
    let(:presenter) { described_class.new(payment_term) }

    subject { presenter.as_json }

    it { is_expected.to eq("translation") }
  end
end
