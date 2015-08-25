require "rails_helper"

describe PaymentTermsPresenter do
  describe "#as_json" do
    let(:translation) do
      create(:translation, value: "translation", locale: locale)
    end
    let(:payment_term) { create(:payment_term, translations: [translation]) }
    let(:presenter) { described_class.new(business_item, locale) }
    let!(:business_item) do
      item = create(:product)
      item.payment_terms << payment_term
      item
    end
    let(:locale) { "en" }

    subject { presenter.as_json }

    it do
      is_expected.to eq(
        ids: { payment_term.id => true },
        names: ["translation"]
      )
    end
  end
end
