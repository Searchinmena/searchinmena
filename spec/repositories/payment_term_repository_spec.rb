require "rails_helper"

describe PaymentTermRepository do
  let(:repository) { PaymentTermRepository.new }

  it_behaves_like "TranslatableRepository"

  describe "#for_business_item" do
    let(:business_item) do
      p = create(:product)
      p.payment_terms << payment_term
      p
    end

    let(:payment_term) { create(:payment_term) }
    let!(:other_payment_term) { create(:payment_term) }
    let(:locale) { "en" }

    before do
      [payment_term, other_payment_term].each do |pt|
        create(:translation, locale: locale, translatable: pt)
      end
    end

    subject { repository.for_business_item(business_item, locale) }

    it { is_expected.to eq([payment_term]) }
  end
end
